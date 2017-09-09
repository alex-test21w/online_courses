FactoryGirl.define do
  factory :lesson do
    title       { FFaker::Book.title }
    position    { rand(10000) }
    descriprion { FFaker::Book.description }
    synopsis    { FFaker::Book.description }
    homework    { FFaker::Book.description }

    course
  end
end
