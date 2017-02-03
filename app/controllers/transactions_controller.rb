class TransactionsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :check_cart!

#   # Other Code

#   private
#   def check_cart!
#     if current_user.get_cart_movies.blank?
#       redirect_to root_url, alert: "Please add some items to your cart before processing your transaction!"
#     end
#   end

    def new
        @price = current_cart.total_cost
        @transaction = Transaction.new
        @items = current_cart.cart_items.all
        gon.client_token = generate_client_token
    end
    
    def index
        @transactions = Transaction.all
    end
    
    def show
        @transaction = Transaction.find_by_id(params[:id])
        @items = @transaction.cart.cart_items.all
        @status = @transaction.retrieve_status
    end
    
    def create
        assign_params = transaction_params.dup
        assign_params.delete(:payment_method_nonce)
        
        @transaction = Transaction.new(assign_params)
        
        if @transaction.valid?
            
            result = Braintree::Transaction.sale(
              :amount => current_cart.total_cost,
              :payment_method_nonce => braintree_params[:payment_method_nonce],
              :options => {
                :submit_for_settlement => true
              }
            )
        
            if result.success?
                @transaction.braintree_id = result.transaction.id
                @transaction.amount = current_cart.total_cost
                @transaction.cart = current_cart
                @transaction.save
                Work.purchase_items(current_cart)
                session[:cart] = Cart.create.id
                redirect_to @transaction, notice: "Congratulations! Your transaction has been successfully processed!"
            else
                flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
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
    
    def transaction_params
        params.require(:transaction).permit( :name, :email, :payment_method_nonce, {:shipping_address => EffectiveAddresses.permitted_params})
    end
    
    
end
