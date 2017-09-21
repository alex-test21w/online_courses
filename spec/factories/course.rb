FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "Course title #{n}" }
    active           { true }

    user

    trait :with_picture do
      picture { File.new("#{Rails.root}/spec/fixtures/pixel.png") }
    end
  end
end
