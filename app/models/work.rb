class Work < ActiveRecord::Base
  has_many :cart_items
  mount_uploader :image, ImageUploader
    
  def Work.get_stock(id)
    work = Work.find_by_id(id)
    return work.quantity - work.cart_items.count
  end
  
  def Work.check_stock(id, quantity)
    return get_stock(id) >= quantity
  end
  
end
