# To-Do List Application

## Sobre o Projeto

O **To-Do List** é um aplicativo desenvolvido para ajudar os usuários a organizar suas tarefas diárias, gerenciar prioridades e acompanhar o progresso de suas listas de tarefas e quadros. O sistema é responsivo, intuitivo e rico em funcionalidades, garantindo uma ótima experiência de usuário.

## Funcionalidades Principais

- **Gestão de Listas:** Criação, edição e exclusão de listas de tarefas personalizadas.
- **Quadros (Boards):** Organização de tarefas em colunas como "To Do", "In Progress" e "Done".
  - Cada Lista tem um Quadro.
  - O usuário pode criar um Quadro baseado na quantidade de horas que ele determina no Quadro. Podendo ser usado para organizar melhor seu dia.
    -O Quadro busca as tasks de maior prioridade e vai contabilizando as horas da task alocando o máximo possível no board mas nunca ultrapassando a quantidade de horas que o usuário estipulou.
- **Tarefas:**
  - Adição, edição e exclusão de tarefas.
  - Marcação de tarefas como concluídas.
  - Acompanhamento de vencimentos com destaques visuais para tarefas atrasadas ou no prazo.
  - Atribuição de prioridades (Alta, Média, Baixa).
- **Pesquisa:** Busca de tarefas por título ou descrição.
- **Sistema de Login:** Autenticação de usuários para garantir acesso seguro.
- **Responsividade:** Interface otimizada para desktops e dispositivos móveis.

## Tecnologias Utilizadas

- **Frontend:**
  - HTML, CSS, Bootstrap
  - Font Awesome para ícones
- **Backend:**
  - Ruby on Rails
- **Banco de Dados:**
  - PostgreSQL
- **Autenticação:**
  - Devise
- **Gerenciamento de Tarefas:**
  - Sortable.js para arrastar e soltar tarefas nos boards

## Configuração do Ambiente

### Requisitos

- Ruby 3.3.6
- Rails 8.0.1
- PostgreSQL
- Node.js e Yarn

### Passos para Configuração

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/todo-list.git
   cd todo-list
   ```

2. Instale as dependências:
   ```bash
   bundle install
   yarn install
   ```

3. Configure o banco de dados:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Inicie o servidor:
   ```bash
   rails server
   ```

5. Acesse o aplicativo em seu navegador:
   ```
   http://localhost:3000
   ```

## Estrutura de Dados

![image](https://github.com/user-attachments/assets/5911f26c-3c7b-40f3-b73b-0ad7bf757c2f)

### Modelos Principais

- **User:** Armazena as informações de login.
- **TodoList:** Representa uma lista de tarefas.
- **Task:** Representa uma tarefa individual dentro de uma lista.
- **DailyBoard:** Um quadro diário para organização visual das tarefas.
- **BoardColumn:** Colunas dentro de quadros para organizar tarefas.
- **TaskAssignment:** Relaciona tarefas com colunas nos quadros.
- **Priority:** Define a prioridade das tarefas.

## Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto.
2. Crie uma branch com sua funcionalidade ou correção:
   ```bash
   git checkout -b minha-feature
   ```
3. Envie suas alterações:
   ```bash
   git push origin minha-feature
   ```
4. Abra um Pull Request.

Obrigado por utilizar o **To-Do List**! Organize suas tarefas de forma eficiente e alcance seus objetivos diários.
