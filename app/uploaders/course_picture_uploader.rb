class CoursePictureUploader < BaseUploader
  version :admin_thumb do
    process resize_and_pad: [140, 100]
  end

  version :thumb do
    process resize_and_pad: [284, 177]
  end
end
