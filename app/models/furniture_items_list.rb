class FurnitureItemsList < ApplicationRecord
  belongs_to :furniture_item
  belongs_to :order
end
