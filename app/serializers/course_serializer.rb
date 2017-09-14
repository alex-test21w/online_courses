class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :picture_url

  has_many :lessons, serializer: LessonSerializer

  def picture_url
    object.picture.thumb.url
  end
end
