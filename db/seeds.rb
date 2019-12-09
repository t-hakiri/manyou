# User.create!(name:  "管理者",
#              email: "admin@example.jp",
#              password:  "hakiri",
#              password_confirmation: "hakiri",
#              admin: true)


10.times do |i|
User.create (name:  "aaa",
             email: "admin@example.jp",
             password:  "hakiri",
             password_confirmation: "hakiri",
             admin: false)
end