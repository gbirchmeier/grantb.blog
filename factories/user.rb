FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "user_#{n}"}
    sequence(:email) {|n| "user_#{n}@example.com"}
    password "password123"
    password_confirmation "password123"
  end
end
