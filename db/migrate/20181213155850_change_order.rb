class ChangeOrder < ActiveRecord::Migration[5.2]
  def change
  	remove_column :orders, :furniture_item_id, :integer
  	remove_column :orders, :count, :integer
  	add_reference :orders, :shop, foreign_key: true
  end
end
