class FurnitureItemsController < ApplicationController
	def index 
		@furniture_items = FurnitureItem.all

		render json: @furniture_items, status: :ok
	end

end
