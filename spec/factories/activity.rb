FactoryGirl.define do
  factory :activity do
    association :recipient, factory: :user
    association :owner, factory: :user
    association :trackable, factory: :homework

    kind    { FFaker::Lorem.word }
    message { FFaker::Lorem.sentence }
  end
end
