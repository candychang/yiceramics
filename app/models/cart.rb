class Cart < ActiveRecord::Base
    has_many :cart_items
    
    def item_count
        return cart_items.count
    end
    
    #need to create cart item lol
    def add_item(item_id)
        item = CartItem.find(work_id: item_id, cart_id: self.id)
        if item
            cart_items << item
        else
            return false
        end
    end
end
