class NotificationsMailer < ApplicationMailer
  def new_lesson(lesson, recipient)
    @recipient = recipient
    @lesson    = lesson

    mail(to: recipient.email, subject: 'New lesson')
  end
end
