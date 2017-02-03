require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:address) { FactoryGirl.create(:address) }
  
  
  describe "required shipping address" do
      let(:transaction) { FactoryGirl.build(:transaction) }

      it "is invalid without an address" do
        expect(transaction).to_not be_valid
        expect(transaction.errors[:shipping_address]).to_not be_empty

        # Now lets make it valid
        transaction.shipping_address = address

        expect(transaction).to be_valid
        expect(transaction.errors[:shipping_address]).to be_empty
      end
    end
end
  

  # describe "#create_with_braintree" do

  #     context "when braintree payment is valid" do
  #         it "creates a new transaction" do
  #           result = double("braintree result")
  #           allow(result).to receive(:success?).and_return(true)
  #           allow(result).to receive_message_chain(:transaction, :id) { "testid123" }
  #           allow(Braintree::Transaction).to receive(:sale).and_return(result)
              
  #           new_transaction = Transaction.create_with_braintree({:amount => 10})
  #           expect(new_transaction).to be_valid
  #         end
              
  #     end
      
  #     context "when braintree payment is invalid" do
  #         it "does not create a new transaction" do
  #           result = double("braintree result")
  #           allow(result).to receive(:success?).and_return(false)  
  #           allow(result).to receive(:errors).and_return({:transaction => "amount cannot be negative"})
  #           new_transaction = Transaction.create_with_braintree({:amount => 10})
  #           expect(new_transaction.instance_of? Transaction).to be_falsey 
  #       end
  #     end
  # end
  
  

