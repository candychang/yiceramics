class Work < ActiveRecord::Base
  has_many :cart_items
  mount_uploader :image, ImageUploader
    
  def in_stock(num_requested=1)
    return quantity >= num_requested
  end
  
  def add_stock(amt)
    quantity += amt
  end
  
  def remove_stock(amt)
    if amt > quantity
      errors.add(:work, "#{amt} requested, only #{quantity} available")
      quantity = 0
    else
      quantity -= amt
    end
  end
  
end
