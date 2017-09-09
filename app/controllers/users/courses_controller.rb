class Users::CoursesController < Users::BaseController
  before_action :find_course, only: [:edit, :update, :destroy]

  PER_PAGE = 5

  def index
    @courses = current_user.authored_courses.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def new
    @course = current_user.authored_courses.build
  end

  def create
    @course = current_user.authored_courses.build(course_params)

    if @course.save
      redirect_to users_courses_path
      flash[:success] = 'Course was successfully created.'
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to users_courses_path
      flash[:success] = 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy!

    redirect_to users_courses_path
  end

  private

  def find_course
    @course = current_user.authored_courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :picture, :active)
  end
end
