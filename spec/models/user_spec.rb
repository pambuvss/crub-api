require 'rails_helper'

RSpec.describe User, type: :model do
	it 'associations' do
		expect belong_to(:shop).optional
	end
end