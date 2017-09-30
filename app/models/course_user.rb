class CourseUser < ApplicationRecord
  scope :recent,       -> { order(created_at: :desc) }
  scope :not_outcast,  -> { where(outcast: false) }
  scope :not_outcast_and_subscription, -> { not_outcast.where(subscription: true) }

  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id }
end
