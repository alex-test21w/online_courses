class CourseUser < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }
  scope :only_subscriptions, -> { where(subscription: true) }

  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id }
end
