class FurnitureItem < ApplicationRecord
	belongs_to :shop
	has_many :furniture_items_list
	
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true  

	def as_json(_opts = {})
    {
      id: id,
      name: name,
      kind: kind,
      description: description,
      length: length,
      width: width,
      price: price,
      image_photos: images.map do |x|
        {
          url: x.photo.url,
          urlThumb: x.photo.url(:thumb),
          name: x.photo_file_name,
          id: x.id
        }
      end
    }
  end
end
