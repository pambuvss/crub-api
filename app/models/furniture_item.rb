class FurnitureItem < ApplicationRecord
	belongs_to :user
	has_many :order
	
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
          url: x.photo.url.absolute_url,
          name: x.photo_file_name,
          id: x.id
        }
      end
    }
  end
end
