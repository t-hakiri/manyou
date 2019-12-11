FactoryBot.define do
  factory :labelling do
    task_id { Task.find(1) }
    label_id { Label.find(1) }
  end
end
