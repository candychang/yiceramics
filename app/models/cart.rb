class Cart < ActiveRecord::Base
    has_many :cart_items
    
    def item_count
    end
end
