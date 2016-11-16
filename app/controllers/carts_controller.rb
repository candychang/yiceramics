class CartsController < ApplicationController
respond_to :json
  def show
      respond_with current_cart.cart_items.as_json
  end
  
  #use respond_with instead
  def add
    if current_cart.add(params[:work_id])
      render json: current_cart.item_count, status: 200
    else
      render json: "failed to add item", status: 500
    end
  end
  
  def remove
    if current_cart.remove(params[:work_id])
      render json: current_cart.item_count, status: 200
    else
      render json: "failed to remove item", status: 500
    end
  end

end
