class Post < ApplicationRecord
  include ImageUploader[:image]

  attr_accessor :image_cropper_x
  attr_accessor :image_cropper_y
  attr_accessor :image_cropper_width
  attr_accessor :image_cropper_height
end
