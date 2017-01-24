class CartItem < ActiveRecord::Base
    belongs_to :cart
    belongs_to :work
    
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :work, presence: true
    validates :cart, presence: true
end
