class Api::V1::CoursesController < Api::V1::BaseController
  respond_to :json

  def index
    courses = Course.recent

    respond_with_success courses
  end
end
