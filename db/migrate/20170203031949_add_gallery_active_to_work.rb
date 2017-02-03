class AddGalleryActiveToWork < ActiveRecord::Migration
  def change
    add_column :works, :gallery_active, :boolean
  end
end
