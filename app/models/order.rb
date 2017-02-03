class Order < ActiveRecord::Base
    acts_as_addressable :shipping
    validates_presence_of :shipping_address
    has_one :cart
    
    def retrieve_status
        bt = Braintree::Transaction.find(self.braintree_id)
        return bt.status
    end
    
end
