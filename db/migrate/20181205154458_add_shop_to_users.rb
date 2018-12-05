class AddShopToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :shop, :string, null: false, default: ""
  end
end
