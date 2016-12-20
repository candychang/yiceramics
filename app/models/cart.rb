class Cart < ActiveRecord::Base
    has_many :cart_items
    has_many :works, :through => :cart_items
    
end
