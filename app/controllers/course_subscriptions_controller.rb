class CourseSubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :if_student_is_outcast, only: :create

  def create
    if current_user.email.present?
      course.participants << current_user unless current_user.participate_in?(course)

      participant.update!(subscription: true)
    else
      add_missing_email
    end
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

    redirect_to courses_path

    flash[:error] = 'You was excluded from the course'
  end

  def add_missing_email
    if request.xhr?
      render partial: 'course_subscriptions/missing_email'
    else
      if params[:user][:email].present?
        if current_user.update(email: params[:user][:email])
          flash[:success] = 'Your email was successfully created'
        else
          flash[:error] = current_user.errors.full_messages.first
        end

        redirect_to courses_path
      else
        flash[:error] = 'Your email cant be empty'

        redirect_to courses_path
      end
    end
  end
end
