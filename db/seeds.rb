User.create!(name:  "管理者",
             email: "admin@example.jp",
             password:  "password",
             password_confirmation: "password",
             admin: true)

status = ["高", "中", "低"]
10.times do |i|
User.create!(name: "test#{i + 1}",
             email: "seed#{i + 1}@example.jp",
             password: "password",
             password_confirmation: "password",
             admin: false)

Task.create!(title: "user#{i +1 }",
             content: "seeddata#{i + 1}",
             deadline: Date.today,
             status: status[rand(3)],
             priority: rand(1..2),
             user_id: User.find(i + 1).id
             )
end
