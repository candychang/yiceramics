class Cart < ActiveRecord::Base
    has_many :cart_items
    
    def item_count
        return cart_items.count
    end
    
    def add_item(item)
        cart_items << item
    end
end
