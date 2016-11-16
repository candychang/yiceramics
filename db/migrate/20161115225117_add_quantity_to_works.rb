class AddQuantityToWorks < ActiveRecord::Migration
  def change
    add_column :works, :quantity, :integer, :default => 1
  end
end
