class CartController < ApplicationController
    def show
        @cart = Cart.find_by_id(params[:id])
    end
end
