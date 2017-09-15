class ScheduleNewLessonNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', failure: true

  def perform(lesson_id)
    lesson = Lesson.find(lesson_id)

    lesson.course.course_users.not_outcast.pluck(:user_id).each do |user_id|
      NewLessonNotificationWorker.perform_async(lesson_id, user_id)
    end
  end
end
