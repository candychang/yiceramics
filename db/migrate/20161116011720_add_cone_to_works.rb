class AddConeToWorks < ActiveRecord::Migration
  def change
    add_column :works, :cone, :integer
  end
end
