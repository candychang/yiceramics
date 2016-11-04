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
        @price = 10.00
        gon.client_token = generate_client_token
    end
    
    def create
        @result = Braintree::Transaction.sale(
          :amount => '10.00',
          :payment_method_nonce => params[:payment_method_nonce],
          :options => {
            :submit_for_settlement => true
          }
        )
        if @result.success?
        #   current_user.purchase_cart_movies!
          render :new, notice: "Congraulations! Your transaction has been successfully processed!"
        else
          flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
          gon.client_token = generate_client_token
          render :new
        end
    end

    private
    def generate_client_token
      Braintree::ClientToken.generate
    end

end
