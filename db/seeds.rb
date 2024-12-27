puts "Iniciando a população do banco de dados..."

  # Populando Priorities
  puts "Criando prioridades..."
  [ 'Alta', 'Media', 'Baixa' ].each_with_index do |nome, indice|
    Priority.find_or_create_by!(name: nome, level: indice + 1)
  end

  puts "Criando um usuário..."
  user = User.find_or_initialize_by(email: 'testee@example.com')
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.save!
  puts "Usuário criado ou atualizado: #{user.inspect}"



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
    daily_board = user.daily_boards.find_or_create_by!(name: 'Quadro diário', total_estimate: 8)
    daily_board.save!
    puts "Daily board criado: #{daily_board.inspect}"

    # Criando colunas para o board usando associação polimórfica
    puts "Criando colunas do quadro..."
    to_do = BoardColumn.find_or_create_by!(
      name: 'To Do',
      position: 1,
      boardable: daily_board
    )
    puts "Coluna 'To Do' criada: #{to_do.inspect}"

    in_progress = BoardColumn.find_or_create_by!(
      name: 'In Progress',
      position: 2,
      boardable: daily_board
    )
    puts "Coluna 'In Progress' criada: #{in_progress.inspect}"

    done = BoardColumn.find_or_create_by!(
      name: 'Done',
      position: 3,
      boardable: daily_board
    )
    puts "Coluna 'Done' criada: #{done.inspect}"

    # Associando tarefas ao board e colunas
    puts "Associando tarefas às colunas do quadro..."
    task1 = todo_list1.tasks.find_by(title: 'Finalização do report para o projeto')
    daily_board.task_assignments.find_or_create_by!(
      task: task1,
      board_column: to_do,
      position: 1
    )

    task2 = todo_list1.tasks.find_by(title: 'Reunião de equipe')
    daily_board.task_assignments.find_or_create_by!(
      task: task2,
      board_column: in_progress,
      position: 1
    )

    task3 = todo_list2.tasks.find_by(title: 'Academia')
    daily_board.task_assignments.find_or_create_by!(
      task: task3,
      board_column: done,
      position: 1
    )

    puts "População do banco de dados concluída!"
