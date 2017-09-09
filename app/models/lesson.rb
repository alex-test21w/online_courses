class Lesson < ApplicationRecord
  mount_uploader :picture, LessonPictureUploader

  belongs_to :course

  has_many :homeworks

  acts_as_list scope: :course

  validates :title, :position, presence: true
end
