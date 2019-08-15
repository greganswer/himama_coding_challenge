FactoryBot.define do
  factory :user do
    first_name { "Jane" }
    last_name  { "Doe" }
    password { 'secret' }
    sequence :email do |n|
      "jane#{n}@example.com"
    end
  end
end