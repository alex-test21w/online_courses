class CourseSubscriptionsController < CourseParticipantSubscriptionsController
  before_action :authenticate_user!
  before_action :if_student_is_outcast, only: :create

  private

  def if_student_is_outcast
    return unless current_user.participate_in?(course) && participant.outcast?

    redirect_to courses_path

    flash[:error] = 'You was excluded from the course'
  end
end
