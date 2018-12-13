class ChangeFurnitureItemsToReferenceToShop < ActiveRecord::Migration[5.2]
  def change
  	add_reference :furniture_items, :shop, foreign_key: true
  	remove_column :furniture_items, :user_id, :integer
  end
end
