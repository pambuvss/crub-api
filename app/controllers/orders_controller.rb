class OrdersController < ApplicationController

	def index
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.customer?
			@orders = Order.all.where user_id: @activeUser.id
			render json: @orders, status: :ok
		elsif @activeUser&.seller?
			@orders = Order.all.where shop_id: @activeUser.shop_id
			render json: @orders, status: :ok
		else
			render json: {}, status: :unauthorized
		end
	end

	def create
		@@activeUser = User.find_by authentication_token: params[:token]

		if @@activeUser&.customer?

			@orderJSON = JSON.parse params[:order]
			
			@array_shops = Array.new

			@orderJSON["furniture_items"].each do |item|
				@array_shops.push(FurnitureItem.find(item["id"]).shop_id)
			end	

			@array_shops = @array_shops.uniq			


			@array_shops.each do |shop_id|
				@order = Order.new(shop_id: shop_id, user_id: @@activeUser.id)
				@order.save
					@orderJSON["furniture_items"].each do |item|
						 if FurnitureItem.find(item["id"]).shop_id == shop_id
							@fil = FurnitureItemsList.new 
							@fil.order_id = @order.id
							@fil.count = item["count"]
							@fil.furniture_item_id = item["id"]
							@fil.save
						 end
					end	
			end
			render json: {}, status: :created
		else
			render json: {}, status: :unauthorized
		end
	end

	def update
	@activeUser = User.find_by authentication_token: params[:token]

    if @activeUser&.seller? && 
      @order = Order.find(params[:id])
      if @order.update(status: params[:status])
      	render json: {}, status: :ok
      end
    else
      render json: {}, status: :unauthorized
    end
  end

end