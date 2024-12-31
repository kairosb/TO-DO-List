# syntax=docker/dockerfile:1

# Define the Ruby version (ensure it matches your .ruby-version)
ARG RUBY_VERSION=3.3.6
FROM ruby:$RUBY_VERSION-slim AS base

# Define o diretório de trabalho
WORKDIR /rails

# Instala pacotes essenciais para runtime
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    nodejs \
    yarn && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Configura variáveis de ambiente para produção
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Build intermediário para instalar dependências e assets
FROM base AS build

# Instala ferramentas de compilação e dependências para gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copia Gemfile e instala gems
COPY Gemfile Gemfile.lock ./ 
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copia o código da aplicação
COPY . .

# Torna os arquivos bin executáveis
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

# Precompila assets
RUN SECRET_KEY_BASE=DUMMY bundle exec rake assets:precompile

# Imagem final para execução
FROM base

# Copia os artefatos construídos
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Cria um usuário não-root para segurança
RUN groupadd --system --gid 1000 rails && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

# Executa migrações antes de iniciar o servidor
CMD ["sh", "-c", "bundle exec rake db:migrate && bundle exec rails server -b 0.0.0.0"]
