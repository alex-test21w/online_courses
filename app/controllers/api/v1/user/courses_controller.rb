class Api::V1::User::CoursesController < Api::V1::User::BaseController
  def index
    courses = current_user.participated_courses.recent

    respond_with_success(
      ActiveModel::Serializer::CollectionSerializer.new(courses, serializer: CourseWithoutAssociationsSerializer)
    )
  end
end
