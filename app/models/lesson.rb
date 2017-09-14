class Lesson < ApplicationRecord
  include AASM

  mount_uploader :picture, LessonPictureUploader

  belongs_to :course

  has_many :homeworks
  has_many :activities, as: :trackable

  acts_as_list scope: :course

  validates :title, :position, :start_date, presence: true

  after_create :send_notifications

  aasm column: :state do
    state :wait_realization, initial: true
    state :load_wait
    state :material_loaded
  end

  private

  def send_notifications
    course.course_users.not_outcast.each do |course_users|
      NotificationsMailer.new_lesson(self, course_users.user).deliver
    end
  end
end
