class FurnitureItemsController < ApplicationController
	
	def index
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.seller?
			@furniture_items = FurnitureItem.where shop_id: @activeUser.shop.id
			render json: @furniture_items, status: :ok
		else
			@furniture_items = FurnitureItem.all
			render json: @furniture_items, status: :ok
		end
	end

	def create
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.seller?
			
			@furniture_item = FurnitureItem.new(furniture_item_params)
			@furniture_item.shop_id = @activeUser.shop_id


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

		if @activeUser&.seller? && @destroyFurnitureItem&.shop_id == @activeUser.shop_id
			if @destroyFurnitureItem.destroy
				render json: {}, status: :ok
			end
		else
			render json: {}, status: :unauthorized
		end
	end

	private

	def furniture_item_params
    	params.require(:furniture_item).permit([
      		:name,
      		:kind,
	        :description,
	        :length,
	        :width,
	        :price,
	        images_attributes: %I[
	           id
	           photo
	           _destroy
	         ]
	       ]
	    )
  	end	

end