class Post < ApplicationRecord
  include ImageUploader[:image]
end
