class Work < ActiveRecord::Base
  has_many :cart_items
  mount_uploader :image, ImageUploader
    
  def in_stock(num_requested)
    return quantity >= num_requested
  end
end
