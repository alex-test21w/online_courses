FactoryGirl.define do
  factory :course do
    title { Faker::Lorem.characters(10) }
    active { true }
  end
end