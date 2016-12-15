class CartsController < ApplicationController
respond_to :json

  def confirm
    item_list = item_params[:items]
    new_list = []
    error_messages = []
    
    for item in item_list do
      new_item = CartItem.where(cart_id: current_cart.id).find_or_initialize_by(work_id: item[:work_id])
      new_item.work_id = item[:work_id]
      new_item.cart_id = current_cart.id
      
      if Work.check_stock(item[:work_id], item[:quantity])
        new_item.quantity = item[:quantity]
        new_item.save
        new_list << item
      else
        stock_left = Work.get_stock(item[:work_id])
        if stock_left > 0 
          new_item.quantity = stock_left
          item[:quantity] = stock_left
          new_list << item
          new_item.save
          error_messages << "Only #{stock_left} left of #{item[:name]}. The quantity in your cart has been adjusted."
        else
          error_messages << "Unfortunately, #{item[:name]} is out of stock."
        end
      end
    end
    
    render json: ({items: new_list, errors: error_messages}), status: 200
  end


  private
  
  def item_params
      params.except(:cart).permit(:items => [:work_id, :name, :price, :quantity, :imageURL])
  end

end
