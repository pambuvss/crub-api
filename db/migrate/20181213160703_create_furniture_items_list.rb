class CreateFurnitureItemsList < ActiveRecord::Migration[5.2]
  def change
    create_table :furniture_items_lists do |t|
    	t.belongs_to :order, index: true
    	t.belongs_to :furniture_item, index: true
    	t.integer :count, null: false
    end
  end
end
