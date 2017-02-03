class Transaction < ActiveRecord::Base
    acts_as_addressable :shipping
    validates_presence_of :shipping_address
    has_one :cart, :foreign_key => "order_id"
    
    def retrieve_status
        bt = Braintree::Transaction.find(self.braintree_id)
        return bt.status
    end
    
    def self.create_with_braintree(transaction_params, amount)
        result = Braintree::Transaction.sale(
          :amount => amount,
          :payment_method_nonce => transaction_params[:payment_method_nonce],
          :options => {
            :submit_for_settlement => true
          }
        )
        
        if result.success?
            assign_params = transaction_params.dup
            assign_params.delete(:payment_method_nonce)
            assign_params[:braintree_id] = result.transaction.id
            return Transaction.create!(assign_params)
        else
            return result.errors
        end
    end
end
