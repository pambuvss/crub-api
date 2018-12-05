class CreateFurnitureItems < ActiveRecord::Migration[5.2]
  def change
    create_table :furniture_items do |t|
    	t.belongs_to :user, index: true
    	t.string :name, null:false 
        t.string :kind, null:false
        t.text :description, null:false
        t.json :images, null:false
        t.float :length, null:false
        t.float :width, null:false
        t.float :price, null:false
      t.timestamps
    end
  end
end
