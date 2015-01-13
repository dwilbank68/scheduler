class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [200, 300]

  version :tiny do
    process resize_to_fill: [20, 20]
  end

  version :small do
    process resize_to_fill: [30, 30]
  end

  version :profile do
    process resize_to_fill: [45, 45]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
