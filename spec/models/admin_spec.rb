require 'rails_helper'

RSpec.describe Admin, type: :model do
    
  let(:testadmin) { FactoryGirl.create(:admin) }
  
  it "has a valid factory" do
      expect(testadmin).to be_valid
  end
  
  it "will not accept invalid email" do
      expect(FactoryGirl.build(:admin, :email => "invalidemail@")).to_not be_valid
  end
  
  it "requires unique email, ignoring case" do
      FactoryGirl.create(:admin, :email => "test@test.com")
      second = FactoryGirl.build(:admin, :email => "TEST@test.com")
      expect(second).to_not be_valid
  end
  
  it "saves email in downcase" do
      uppercase = "UPPERCASE@test.com"
      testadmin.email = uppercase
      testadmin.save
      expect(testadmin.reload.email).to eq(uppercase.downcase)
  end
  
  it "requires nonblank password" do
      testadmin.password = testadmin.password_confirmation = " " * 8
      expect(testadmin).to_not be_valid
  end
  
  it "requires minimum 8 character password" do
      testadmin.password = testadmin.password_confirmation = "a" * 6
      expect(testadmin).to_not be_valid
  end
  
end
