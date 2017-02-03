class AddShopActiveToWork < ActiveRecord::Migration
  def change
    add_column :works, :shop_active, :boolean
  end
end
