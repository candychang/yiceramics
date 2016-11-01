class Work < ActiveRecord::Base
    mount_uploader :image, ImageUploader
end
