FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| FactoryHelper.email(n) }
    sequence(:username) { |n| FactoryHelper.username(n) }
    password 'password'
  end
end

