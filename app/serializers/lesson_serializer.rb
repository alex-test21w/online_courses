class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :picture_url

  belongs_to :course

  def picture_url
    object.picture.thumb.url
  end
end
