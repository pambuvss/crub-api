class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :furniture_item, index: true
    	t.integer	 :count, null: false
    	t.integer 	 :status, null: false, default: 0
    end
  end
end
