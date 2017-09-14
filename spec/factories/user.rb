FactoryGirl.define do
  factory :user do
    email       { FFaker::Internet.email }
    password    '123456'

    trait :add_trainer do
      after(:create) { |user| user.add_role(:trainer) }
    end

    trait :user_skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
