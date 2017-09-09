FactoryGirl.define do
  factory :course_user do
    outcast      { false }
    subscription { false }

    user
    course
  end
end
