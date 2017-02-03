class Work < ActiveRecord::Base
  has_many :cart_items
  has_many :carts, :through => :cart_items
  
  mount_uploader :image, ImageUploader
    
  def Work.get_stock(id)
    work = Work.find_by_id(id)
    reserved = 0
    work.cart_items.each do |c|
      reserved += c.quantity
    end
    return work.quantity - reserved
  end
  
  def Work.check_stock(id, quantity)
    return get_stock(id) >= quantity
  end
  
  def Work.purchase_items(cart)
    cart.cart_items.all.each do |c|
      work = c.work
      work.quantity -= c.quantity
      
      if work.quantity <= 0
        work.shop_active = false
      end
      work.save
    end
  end
end
