FactoryBot.define do
  factory :clock_event do
    user
    clock_in_at { 1.hour.ago }
    
    trait :clocked_out do
      clock_out_at { Time.current }
    end
  end
end