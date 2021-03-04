FactoryBot.define do
  factory :user do
    username { 'Javier' }
    email { 'javier@gmail.com' }
    password { 'password' }
    status { 'student' }
  end
end