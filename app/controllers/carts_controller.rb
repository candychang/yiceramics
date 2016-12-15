class CartsController < ApplicationController
respond_to :json

  def confirm
    item_list = item_params[:items]
    new_item = CartItem.new
    for item in item_list do
      new_item.work_id = item[:work_id]
      new_item.cart_id = current_cart.id
      
      if Work.check_stock(item[:work_id], item[:quantity])
        new_item.quantity = item[:quantity]
        new_item.save
      else
        stock_left = Work.get_stock(item[:work_id], item[:quantity])
        if stock_left > 0 
          new_item.quantity = stock_left
          item[:quantity] = stock_left
          new_item.save
          flash[:notice] = "Only {{stock_left}} left of {{item[name]}}. The quantity in your cart has been ajusted."
        else
          flash[:notice] = "Unfortunately, {{item[name]}} is out of stock."
        end
      end
    end
    
    respond_with item_params[:items]
  end


  private
  
  def item_params
      params.permit(:items => [:work_id, :name, :price, :quantity, :imageURL])
  end

end
