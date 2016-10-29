class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.text :details
      t.string :size
      t.string :clay_type
      t.string :fire_type

      t.timestamps null: false
    end
  end
end
