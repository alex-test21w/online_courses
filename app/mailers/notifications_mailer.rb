class NotificationsMailer < ApplicationMailer
  def new_lesson(lesson, recipient)
    @recipient = recipient
    @lesson    = lesson

    mail(to: recipient.email, subject: 'New lesson')
  end

  def approve_homework(homework)
    @recipient = homework.user
    @homework  = homework

    mail(to: @recipient.email, subject: 'Your homework was approved')
  end

  def reject_homework(homework)
    @recipient = homework.user
    @homework  = homework

    mail(to: @recipient.email, subject: 'Your homework was rejected')
  end

  def reminder_of_lessons(lesson, user_id)
    @lesson    = lesson
    @course    = lesson.course
    @recipient = User.find(user_id)

    mail(to: @recipient.email, subject: 'The lesson will begin through 1 day')
  end
end
