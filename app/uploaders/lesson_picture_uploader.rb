class LessonPictureUploader < BaseUploader
  version :thumb do
    process resize_and_pad: [284, 177]
  end
end
