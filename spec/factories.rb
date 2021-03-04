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

  factory :course do
    link { 'zoom.com' }
    provider { 'zoom' }
    title { 'Sushi in 30 mins' }
    content { 'Sushi preparation' }
    association :teacher, factory: :user
    status { 'Open' }
    price { 10 }
  end

  factory :subscription do
    user
    course
    confirmed { true }
  end
end