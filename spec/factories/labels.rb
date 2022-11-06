FactoryBot.define do
  factory :label do
    name { "sample_1" }
  end

  factory :second_label, class: Label do 
    name { "sample_2" }
  end


  factory :third_label, class: Label do 
    name { "sample_3" }
  end
end
