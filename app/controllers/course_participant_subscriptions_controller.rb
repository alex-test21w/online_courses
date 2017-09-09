class CourseParticipantSubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :if_student_is_outcast, only: :create

  def create
    course.participants << current_user unless current_user.participate_in?(course)

    participant.update!(subscription: true)
  end

  def destroy
    participant.update!(subscription: false)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def participant
    @participant ||= course.find_participant(current_user)
  end

  def if_student_is_outcast
    return unless current_user.participate_in?(course) && participant.outcast?

    redirect_to course_participants_path(course)

    flash[:error] = 'You was excluded from the course'
  end
end
