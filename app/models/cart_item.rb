class CartItem < ActiveRecord::Base
    belongs_to :cart
    belongs_to :work
    
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :work, presence: true
    validates :work_available
    validates :cart, presence: true
    
    def increase_quantity(amt)
      work.remove_stock(amt)
      quantity += amt
    end
    
    def decrease_quantity(amt)
      amt = (quantity > amt) ? amt : quantity
      work.add_stock(amt)
      quantity -= amt
    end
    
    
    private
    
    def work_available
      if !work.in_stock(quantity)
          errors.add(:work, "Not enough in stock: only #{work.quantity} left.")
      end
    end
end
