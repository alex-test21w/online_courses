class CourseWithoutAssociationsSerializer < ActiveModel::Serializer
  attributes :id, :title, :picture_url

  def picture_url
    object.picture.thumb.url
  end
end
