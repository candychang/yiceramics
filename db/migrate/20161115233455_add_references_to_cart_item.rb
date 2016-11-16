class AddReferencesToCartItem < ActiveRecord::Migration
  def change
    add_reference :cart_items, :work, index: true, foreign_key: true
    add_reference :cart_items, :cart, index: true, foreign_key: true
  end
end
