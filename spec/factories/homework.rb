FactoryGirl.define do
  factory :homework do
    description { FFaker::Lorem.paragraphs }

    lesson
    user
  end
end
