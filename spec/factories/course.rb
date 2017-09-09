FactoryGirl.define do
  factory :course do
    title  { Faker::Lorem.characters(10) }
    active { true }

    user

    trait :with_course_users do
      after(:create) { |course| course.course_users }
    end
  end
end
