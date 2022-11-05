FactoryBot.define do
  factory :user do
    name { "hoge" }
    email { "hoge@hoge.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end

  factory :second_user, class: User do
    name { "fuga" }
    email { "fuga@fuga.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end
