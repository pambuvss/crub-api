class ChangeUserToReferenceToShop < ActiveRecord::Migration[5.2]
  def change
  	add_reference :users, :shop, foreign_key: true
  	remove_column :users, :shop, :string
  end
end
