class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :braintree_id

      t.timestamps null: false
    end
  end
end
