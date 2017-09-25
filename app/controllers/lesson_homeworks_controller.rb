class LessonHomeworksController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:homework].present?
      if params[:homework][:description].present?
        homework = lesson.homeworks.build(homework_params)
        homework.save!

        redirect_to course_lesson_path(course_id: course, id: lesson.id)
        flash[:success] = 'The homework was created'
      else
        flash[:error] = 'Description can\'t be empty'
        redirect_to course_lesson_path(course_id: course, id: lesson.id)
      end
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def lesson
    @lesson ||= course.lessons.find(params[:lesson_id])
  end

  def homework_params
    { description: params[:homework][:description], user_id: current_user.id }
  end
end
