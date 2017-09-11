class CourseLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_lesson, only: :show
  before_action :if_student_is_outcast, only: [:index, :show]

  PER_PAGE = 10

  def index
    @lessons = course.lessons.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    authorize! :manage, course
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def load_lesson
    @lesson = course.lessons.find(params[:id])
  end

  def participant
    @participant = course.find_participant(current_user)
  end

  def if_student_is_outcast
    return unless current_user.participate_in?(course) && participant.outcast?

    redirect_to courses_path

    flash[:error] = 'You was excluded from the course'
  end
end
