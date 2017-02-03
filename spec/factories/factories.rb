require 'faker'

FactoryGirl.define do
  factory :transaction do |f|
    f.braintree_id    { Faker::Lorem.characters(12) }
    f.name            { Faker::Name.name }
    f.email           { Faker::Internet.safe_email }
  end
  
  factory :address, :class => Effective::Address do 
    category 'billing'
    full_name 'Peter Pan'
    sequence(:address1) { |n| "1234#{n} Fake Street" }
    city 'San Antonio'
    state_code 'TX'
    country_code 'US'
    postal_code '92387'
  end
  
  factory :work do |f|
    f.name      "Sample Work"
    f.details   { Faker::Lorem.paragraph }
    f.price     { Faker::Number.decimal(2) }
    f.size      "5inx5inx5in"
    f.cone      { Faker::Number.between(4,10) }
    f.quantity  { Faker::Number.between(1, 10) }
    f.gallery_active true
    f.shop_active true
    
    factory :only_gallery_work do 
      gallery_active true
      shop_active false
    end
    
    factory :only_shop_work do
      gallery_active false
      shop_active true
    end
  end
  
  factory :cart_item do |f|
    work
    cart
    f.quantity    { Faker::Number.between(1, work.quantity) }
  end
  
  factory :cart do 
  end
  
end