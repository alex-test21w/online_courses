class ReminderOfLessonsNotificationWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, failure: true

  def perform
    Lesson.where('start_date = ?', Date.today+1).each do |lesson|

      lesson.course.course_users.where(outcast: false, subscription: true).pluck(:user_id).each do |user_id|
        NotificationsMailer.reminder_of_lessons(lesson, user_id).deliver
      end
    end
  end
end
