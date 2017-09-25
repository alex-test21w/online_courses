class Users::LessonsController < Users::BaseController
  before_action :find_lesson, only: %i[show edit update destroy]

  PER_PAGE = 10

  def index
    @lessons = course.lessons.order_by_position.page(params[:page]).per(params[:per_page] || PER_PAGE).decorate
  end

  def new
    @lesson = course.lessons.build
  end

  def create
    @lesson = course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to users_course_lessons_path(course)

      flash[:success] = 'Lesson was successfully created.'
    else
      render :new
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to users_course_lessons_path(course)

      flash[:success] = 'Lesson was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy!

    redirect_to users_course_lessons_path(course)
  end

  private

  def find_lesson
    @lesson = course.lessons.find(params[:id]).decorate
  end

  def course
    @course ||= current_user.authored_courses.find(params[:course_id])
  end
  helper_method :course

  def lesson_params
    params.require(:lesson).permit(:title, :position, :description, :picture, :synopsis, :homework, :start_date)
  end
end
