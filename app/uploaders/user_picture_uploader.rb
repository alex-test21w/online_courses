class UserPictureUploader < BaseUploader
  version :thumb do
    process resize_and_pad: [160, 160]
  end
end
