FactoryBot.define do
  factory :user do
    username { 'Javier' }
    email { 'javier@gmail.com' }
    password { 'password' }
    status { 'student' }
  end

  factory :friendship do
    association :receiver, factory: :user
    association :sender, factory: :user
    confirmed { true }
  end
end