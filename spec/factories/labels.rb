FactoryBot.define do
  factory :label do
    name { "Label0" }
  end
  factory :label1, class: Label do
    name { "Label1" }
  end
  factory :label2, class: Label do
    name { "Label2" }
  end
end
