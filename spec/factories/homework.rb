FactoryGirl.define do
  factory :homework do
    description { FFaker::Lorem.paragraphs }

    lesson
  end
end
