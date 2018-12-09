class FurnitureItemsController < ApplicationController
	
	def index 
		@furniture_items = FurnitureItem.all

		render json: @furniture_items, status: :ok
	end

	def create
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.seller?
			@furniture_item = FurnitureItem.new(params[:furniture_item])
			render json: params[:furniture_item], status: :created
#			if @furniture_item.save
#				render json: {}, status: :created
#			else 
#				render json: {}, status: :ok
#			end
#		else
#			render json: {}, status: :unauthorized
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

	def furniture_item_params
    	params.require(:furniture_item).permit([
      		:user_id,
      		:name,
	        :description,
      		:kind,
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