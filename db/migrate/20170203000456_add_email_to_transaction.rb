class AddEmailToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :email, :string
  end
end
