class Api::V1::User::CourseSubscriptionsController < Api::V1::User::BaseController
  def create
    if current_user.participate_in?(course)
      render_error 'You have already been subscribed to the course', 403
    else
      course.participants << current_user

      participant.update!(subscription: true)

      render_success 'You have successfully subscribed to the course', 201
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def participant
    @participant ||= course.find_participant(current_user)
  end
end
