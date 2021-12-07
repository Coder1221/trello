10.times do |i|
    user = User.create!(
      email: Faker::Internet.email,
      password: 'admin123',
      username: Faker::Name.unique.name
    )
    5.times do |x|        
        board = user.boards.create!(name: Faker::FunnyName.name)
           3.times do |d|
            list = board.lists.create!(name: Faker::University.name , user_id: user.id)
            4.times do |task|
                list.todos.create!(title: Faker::Hobby.activity , description: Faker::Quote.matz , due_date: Faker::Date.forward(days: 10) )
            end
        end
    end
end