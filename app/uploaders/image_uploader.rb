require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing

  # process(:store) do |io, context|
  #   image_cropper_x = context[:record].image_cropper_x
  #   image_cropper_y = context[:record].image_cropper_y
  #   image_cropper_width = context[:record].image_cropper_width
  #   image_cropper_height = context[:record].image_cropper_height
  #   resize_to_limit!(io.download, 800, 800) { |cmd| cmd.auto_orient } # orient rotated images
  # end

  process(:store) do |io, context|
    if cropping_params_present?(context)
      image_cropper_x = context[:record].image_cropper_x
      image_cropper_y = context[:record].image_cropper_y
      image_cropper_width = context[:record].image_cropper_width
      image_cropper_height = context[:record].image_cropper_height

      cropped = crop(io.download, image_cropper_width, image_cropper_height, image_cropper_x, image_cropper_y, gravity: "NorthWest")
    else
      io
    end
  end

  def cropping_params_present?(context)
    if context[:record].image_cropper_x.present? && context[:record].image_cropper_y.present? && context[:record].image_cropper_width.present? && context[:record].image_cropper_height.present?
      true
    else
      false
    end
  end
end
