class OrdersController < ApplicationController
#   before_action :authenticate_user!
  # skip_before_action :check_cart!, only: [:show, :index]

    def new
        @price = current_cart.total_cost
        @order = Order.new
        @items = current_cart.cart_items.all
        gon.client_token = generate_client_token
    end
    
    def index
        @orders = Order.all
    end
    
    def show
        @order = Order.find(params[:id])
        if @order
          @items = @order.cart.cart_items.all
          @status = @order.retrieve_status
        end
    end
    
    def create
        assign_params = order_params.dup
        assign_params.delete(:payment_method_nonce)
        
        @order = Order.new(assign_params)
        
        if @order.valid?
            
            result = Braintree::Transaction.sale(
              :amount => current_cart.total_cost,
              :payment_method_nonce => braintree_params[:payment_method_nonce],
              :options => {
                :submit_for_settlement => true
              }
            )
        
            if result.success?
                @order.braintree_id = result.transaction.id
                @order.amount = current_cart.total_cost
                @order.cart = current_cart
                @order.save
                Work.purchase_items(current_cart)
                session[:cart] = Cart.create.id
                redirect_to @order, notice: "Congratulations! Your order has been successfully processed!"
            else
                flash[:alert] = "Something went wrong while processing your payment information. Please try again!"
                error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
                flash[:error] = error_messages
                gon.client_token = generate_client_token
                @items = current_cart.cart_items.all
                @price = current_cart.total_cost
                render :new
              end
        else
          flash[:alert] = "Something went wrong while saving your information. Please try again!"
          gon.client_token = generate_client_token
          @items = current_cart.cart_items.all
          @price = current_cart.total_cost
          render :new 
        end
        
    end

    private
    def generate_client_token
      Braintree::ClientToken.generate
    end
    
    def braintree_params
        params.permit(:payment_method_nonce)
    end
    
    def order_params
        params.require(:order).permit( :name, :email, :payment_method_nonce, {:shipping_address => EffectiveAddresses.permitted_params})
    end
    
    # def check_cart!
    #   if current_cart.cart_items.count == 0
    #     flash[:notice] = "Please add some items to your cart before checkout!"
    #     redirect_to shop_index_path
    #   end
    # end
    
end
