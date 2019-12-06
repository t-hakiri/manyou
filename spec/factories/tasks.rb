# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'task' }
    content { 'task' }
    deadline { Date.today }
    status { '未着手' }
    priority { '低' }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'second_task' }
    content { 'second_task' }
    deadline { Date.tomorrow }
    status { '完了' }
    priority { '高' }
  end
end