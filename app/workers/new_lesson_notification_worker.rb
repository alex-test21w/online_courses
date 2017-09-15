class NewLessonNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', retry: true, failure: true

  def perform(lesson_id, user_id)
    lesson = Lesson.find(lesson_id)
    user   = User.find(user_id)

    NotificationsMailer.new_lesson(lesson, user).deliver
  end
end
