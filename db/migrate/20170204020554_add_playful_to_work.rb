class AddPlayfulToWork < ActiveRecord::Migration
  def change
    add_column :works, :playful, :boolean, :default => true
  end
end
