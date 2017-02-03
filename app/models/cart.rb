class Cart < ActiveRecord::Base
    has_many :cart_items
    has_many :works, :through => :cart_items
    belongs_to :order, :class_name => "Transaction"
    
    SHIPPING_RATE = 13.45
    TAX_RATE = 0.085
    
    def total_cost
        cost = 0.00
        
        if cart_items.count == 0
            return cost
        else
            cart_items.all.each do |c|
                cost += c.work.price * c.quantity
            end
            
            tax = cost * TAX_RATE
            cost = cost + tax + SHIPPING_RATE
            
            return cost.round(2)
        end
    end
end
