class Shop < ApplicationRecord

	has_many :user
	has_many :furniture_item
	has_many :order
end
