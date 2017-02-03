class AddReferenceToCart < ActiveRecord::Migration
  def change
    add_reference :carts, :order, index: true, foreign_key: true
  end
end
