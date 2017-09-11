class CourseUser < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }

  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id }
end
