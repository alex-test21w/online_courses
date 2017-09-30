FactoryGirl.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson title #{n}" }
    position         { 1 }
    description      { FFaker::Lorem.paragraphs }
    synopsis         { FFaker::Lorem.paragraph }
    homework         { FFaker::Lorem.paragraphs }
    start_date       { Date.today + 3 }

    course
  end
end
