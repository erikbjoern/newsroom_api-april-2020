FactoryBot.define do
  factory :user do
    email { "MyString@mail.com" }
    name { "User Example" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
