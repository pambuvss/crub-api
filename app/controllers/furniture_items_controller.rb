class FurnitureItemsController < ApplicationController
	
	before_action :cors_set_access_control_headers

	def index 
		@furniture_items = FurnitureItem.all

		render json: @furniture_items, status: :ok
	end

	def create
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.seller?
			@furniture_item = FurnitureItem.new( user_id: @activeUser.id, name: params[:name],
				description: params[:description], kind: params[:kind],images: params[:images],
				length: params[:length], width: params[:width], price: params[:price])
			if @furniture_item.save
				render json: {}, status: :created
			else 
				render json: {}, status: :ok
			end
		else
			render json: {}, status: :unauthorized
		end
	end

	def show
		@furniture_item = FurnitureItem.find(params[:id])
		render json: @furniture_item, status: :ok
	end

	def destroy
		@activeUser = User.find_by authentication_token: params[:token]
		@destroyFurnitureItem = FurnitureItem.find(params[:id])

		if @activeUser&.seller? && @destroyFurnitureItem&.user_id == @activeUser.id
			if @destroyFurnitureItem.destroy
				render json: {}, status: :ok
			end
		else
			render json: {}, status: :unauthorized
		end
	end


	private
		def cors_set_access_control_headers
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
			headers['Access-Control-Request-Method'] = '*'
			headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	  	end
end
