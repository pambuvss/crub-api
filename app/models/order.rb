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
          count: x.count,
          image_photos: x.furniture_item.images.map do |p|
            {
              url: p.photo.url,
              urlThumb: p.photo.url(:thumb),
              name: p.photo_file_name,
              id: p.id
            }
          end
        }
      end
    }
  end
end
