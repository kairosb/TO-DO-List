puts "Iniciando a população do banco de dados..."

  # Populando Priorities
  puts "Criando prioridades..."
  [ 'Alta', 'Media', 'Baixa' ].each_with_index do |nome, indice|
    Priority.find_or_create_by!(name: nome, level: indice + 1)
  end

  puts "População do banco de dados concluída!"
