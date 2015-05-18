class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [200, 300]
  # process :resize_and_pad => [200, 300,"#000", "Center"]

  version :tiny do
    process resize_to_fill: [20, 20]
    # process resize_and_pad: [20, 20,"#000", "Center"]
  end

  version :small do
    process resize_to_fill: [30, 30]
    # process resize_and_pad: [30, 30,"#000", "Center"]
  end

  version :profile do
    process resize_to_fill: [45, 45]
    # process resize_and_pad: [45, 45,"#000", "Center"]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
