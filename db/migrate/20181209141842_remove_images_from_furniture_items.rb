class RemoveImagesFromFurnitureItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :furniture_items, :images, :json
  end
end
