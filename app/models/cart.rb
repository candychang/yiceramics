class Cart < ActiveRecord::Base
    has_many :cart_items
    
    def item_count
        return cart_items.count
    end
    
    #need to create cart item lol
    def add_item(item_id)
        item = Cart.cart_items.find_by_id(work_id: item_id)
        if item
            item.quantity += 1
        else
            item = Cart.new(work_id: item_id, cart_id: self.id, quantity: 1)
        end
    end
end
