require 'rails_helper'

RSpec.describe FurnitureItem, type: :model do
	it 'associations' do
		expect belong_to(:shop)
		expect have_many(:images).dependent(:destroy)
	end
end