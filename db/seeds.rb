# Este arquivo garante a existência de registros necessários para a execução da aplicação em todos os ambientes (produção, desenvolvimento, teste).
# O código aqui deve ser idempotente, ou seja, pode ser executado várias vezes sem criar duplicações.

puts "Iniciando a população do banco de dados..."

  # Populando Priorities
  puts "Criando prioridades..."
  [ 'Alta', 'Media', 'Baixa' ].each_with_index do |nome, indice|
    Priority.find_or_create_by!(name: nome, level: indice + 1)
  end

  # Criando um usuário
  puts "Criando um usuário..."
  user = User.find_or_create_by!(name: 'Kairo', email: 'kairo@example.com')

  # Criando listas de tarefas
  puts "Criando listas de tarefas..."
  todo_list1 = user.todo_lists.find_or_create_by!(name: 'Tarefas de Trabalho')
  todo_list2 = user.todo_lists.find_or_create_by!(name: 'Tarefas Pessoais')

  # Adicionando tarefas às listas
  puts "Adicionando tarefas às listas..."
  todo_list1.tasks.find_or_create_by!(
    title: 'Finalização do report para o projeto',
    description: 'Completar o report para finalização do projeto',
    estimate: 4,
    completed: false,
    priority: Priority.find_by(name: 'Alta')
  )

  todo_list1.tasks.find_or_create_by!(
    title: 'Reunião de equipe',
    description: 'Discutir sobre novos passos para o projeto',
    estimate: 2,
    completed: false,
    priority: Priority.find_by(name: 'Media')
  )

  todo_list2.tasks.find_or_create_by!(
    title: 'Ir ao mercado',
    description: 'Comprar frutas e pão',
    estimate: 1,
    completed: false,
    priority: Priority.find_by(name: 'Baixa')
  )

  todo_list2.tasks.find_or_create_by!(
    title: 'Academia',
    description: 'Treinar braço',
    estimate: 1,
    completed: true,
    priority: Priority.find_by(name: 'Media')
  )

  # Criando um board diário
  puts "Criando um quadro diário..."
  daily_boards = user.daily_boards.find_or_create_by!(name: 'Quadro diário', total_estimate: 8)

  # Criando colunas para o board
  puts "Criando colunas do quadro..."
  to_do = daily_boards.board_columns.find_or_create_by!(name: 'To Do', position: 1)
  in_progress = daily_boards.board_columns.find_or_create_by!(name: 'In Progress', position: 2)
  done = daily_boards.board_columns.find_or_create_by!(name: 'Done', position: 3)

  # Associando tarefas ao board e colunas
  puts "Associando tarefas às colunas do quadro..."
  daily_boards.task_assignments.find_or_create_by!(
    task: todo_list1.tasks.find_by(title: 'Finalização do report para o projeto'),
    board_column: to_do,
    position: 1
  )

  daily_boards.task_assignments.find_or_create_by!(
    task: todo_list1.tasks.find_by(title: 'Reunião de equipe'),
    board_column: in_progress,
    position: 1
  )

  daily_boards.task_assignments.find_or_create_by!(
    task: todo_list2.tasks.find_by(title: 'Academia'),
    board_column: done,
    position: 1
  )

  puts "População do banco de dados concluída!"
