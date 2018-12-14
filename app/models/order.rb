class Order < ApplicationRecord
	belongs_to :user
	belongs_to :shop
	has_many :furniture_items_list

	enum status: [:during, :complete, :canceled]
	
	after_initialize :set_default_status, :if => :new_record?

	def set_default_status
		self.status ||= :during
	end

def as_json(_opts = {})
    {
      id: id,
      customer: user.email,
      shop: shop.name,
      status: status,
      furniture_items: furniture_items_list.map do |x|
        {
          name: x.furniture_item.name,
          price: x.furniture_item.price,
          count: x.count
        }
      end
    }
  end
end
