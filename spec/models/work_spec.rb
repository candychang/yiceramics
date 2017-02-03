require 'rails_helper'

RSpec.describe Work, type: :model do
    let(:work1) { FactoryGirl.create(:work, quantity: 1) }
    let(:work2) { FactoryGirl.create(:work, quantity: 2) }
    let(:work3) { FactoryGirl.create(:work, quantity: 3) }
    let(:cart) { FactoryGirl.create(:cart) }
    
  describe "::purchase_items" do 
      it "updates inventory to account for purchased items" do

          CartItem.create(work_id: work1.id, cart_id: cart.id, quantity: 1)
          CartItem.create(work_id: work2.id, cart_id: cart.id, quantity: 1)
          Work.purchase_items(cart)
          expect(work1.reload.quantity).to eq(0)
          expect(work1.reload.shop_active).to be false
          
          expect(work2.reload.quantity).to eq(1)
          expect(work2.reload.shop_active).to be true
      end
          
         
  end
  
  describe "::check_stock" do
      it "checks availability of an item against requested quantity"
  end
  
  describe "::get_stock" do
      it "returns available stock, minus items in reserve"
  end
end
