class Course < ApplicationRecord
  mount_uploader :picture, CoursePictureUploader

  scope :recent,      -> { order(created_at: :desc) }
  scope :visible,     -> { where(active: true) }

  belongs_to :user

  has_many :course_users
  has_many :participants, -> { where('course_users.subscription = ?', true) }, through: :course_users, source: :user
  has_many :lessons, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }

  def lesson_positions
    lessons.size + 1
  end

  def find_participant(user)
    course_users.where(user_id: user).first
  end
end
