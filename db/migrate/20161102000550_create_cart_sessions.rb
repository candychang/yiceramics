class CreateCartSessions < ActiveRecord::Migration
  def change
    create_table :cart_sessions do |t|

      t.timestamps null: false
    end
  end
end
