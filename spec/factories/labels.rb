FactoryBot.define do
  factory :label do
    name { "仕事" }
  end
  factory :label2, class: Label do
    name { "遊び" }
  end
end
