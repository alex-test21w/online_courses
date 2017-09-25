class ExpelParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    if course.user_id == current_user.id
      course_participant = course.find_participant(params[:user_id])
      course_participant.update!(outcast: true)
    else
      redirect_to course_participants_path(course)
      flash[:error] = 'You aren\'t the creator of the course'
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def user
    @user ||= User.find(params[:user_id])
  end
  helper_method :user
end
