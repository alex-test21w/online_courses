class Course < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  mount_uploader :picture, CoursePictureUploader

  scope :recent, -> { order(created_at: :desc) }
end
