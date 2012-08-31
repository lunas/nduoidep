require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name.downcase }
    email { Faker::Internet.email }

    password "foobar"
    password_confirmation "foobar"
  end
end

