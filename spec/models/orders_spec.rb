require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:address) { FactoryGirl.create(:address) }
  
  
  describe "required shipping address" do
      let(:order) { FactoryGirl.build(:order) }

      it "is invalid without an address" do
        expect(order).to_not be_valid
        expect(order.errors[:shipping_address]).to_not be_empty

        # Now lets make it valid
        order.shipping_address = address

        expect(order).to be_valid
        expect(order.errors[:shipping_address]).to be_empty
      end
  end
  
  describe "#retrieve_status" do 
    it "returns the transaction status from Braintree"
  end
  
end
  
  

