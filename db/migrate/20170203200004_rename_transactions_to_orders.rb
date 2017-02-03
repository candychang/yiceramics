class RenameTransactionsToOrders < ActiveRecord::Migration
  def change
    rename_table :transactions, :orders
  end
end
