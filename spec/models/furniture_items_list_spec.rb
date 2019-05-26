require 'rails_helper'

RSpec.describe FurnitureItemsList, type: :model do
	it 'associations' do
		expect belong_to(:furniture_item)
		expect belong_to(:order)
	end
end