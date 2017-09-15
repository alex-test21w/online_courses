class RejectHomeworkNotificationWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, failure: true

  def perform(homework_id)
    homework = Homework.find(homework_id)

    NotificationsMailer.reject_homework(homework).deliver
  end
end
