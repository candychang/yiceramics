class AddPriceToWorks < ActiveRecord::Migration
  def change
    add_column :works, :price, :decimal, :precision => 12, :scale => 3
  end
end
