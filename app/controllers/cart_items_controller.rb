class CartItemsController < ApplicationController
    def create
        @cart = current_cart
        @cart_item = current_cart.cart_items.new(cart_item_params)
        @cart.save
    end
    
    def update
        @cart = current_cart
        @cart_item = current_cart.cart_items.find(params[:id])
        @cart_item.update_attributes(cart_item_params)
    end
    
    def destroy
        @cart = current_cart
        @cart_item = current_cart.cart_items.find(params[:id])
        @cart_item.destroy
    end
            
    private
    
    def cart_item_params
    end
end
