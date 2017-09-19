FactoryGirl.define do
  factory :lesson do
    title       { FFaker::Book.title }
    position    { rand(10000) }
    description { FFaker::Book.description }
    synopsis    { FFaker::Book.description }
    homework    { FFaker::Book.description }
    start_date  { Date.today + 3 }

    course

    after(:build) do |lesson|
      lesson.class.skip_callback(:commit, :after, :send_notifications, raise: false)
    end
  end
end
