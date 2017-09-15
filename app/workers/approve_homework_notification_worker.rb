class ApproveHomeworkNotificationWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, failure: true

  def perform(homework_id)
    homework = Homework.find(homework_id)

    NotificationsMailer.approve_homework(homework).deliver
  end
end
