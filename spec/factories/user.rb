# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  
  factory :user do
    name { 'test_1' }
    email { 'test7@aa.aa' }
    password { 'testtesttest' }
    password_confirmation { 'testtesttest' }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :user2, class: User do
    name { 'test_2' }
    email { 'test8@aa.aa' }
    password { 'testtesttest2' }
    password_confirmation { 'testtesttest2' }
  end
end