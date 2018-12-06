class OrdersController < ApplicationController

	def index
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.customer?
			@orders = Order.all.where user_id: @activeUser.id
			render json: @orders, status: :ok
		elsif @activeUser&.seller?
			@orders = Order.joins(:furniture_item).where('furniture_items.
				user_id ='+ @activeUser.id.to_s);
			render json: @orders, status: :ok
		else
			render json: {}, status: :unauthorized
		end
	end

	def create
		@@activeUser = User.find_by authentication_token: params[:token]

		if @@activeUser&.customer?

			@orderJSON = JSON.parse params[:order]
			
			@orderJSON["furniture_items"].each do |item|
  				@order = Order.new(user_id: @@activeUser.id, 
  					furniture_item_id: item["id"], count: item["count"])
  				@order.save
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