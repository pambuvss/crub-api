class SellersController < ApplicationController

	def index	
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.admin?
			@sellers = User.all.where role: :seller
			render json: @sellers, status: :ok
		else
			render json: {}, status: :unauthorized
		end
	end

	def create
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.admin?

			@shop = Shop.find_by name: params[:shop]

			if !@shop
				@shop = Shop.new(name: params[:shop])
				@shop.save
			end				


			@user = User.new(email: params[:email], password: params[:password],
			 password_confirmation: params[:password_confirmation],
			 shop_id: @shop.id,	role: 1)
			if @user.save
				render json: {}, status: :created
			else 
				render json: {}, status: :ok
			end
		else
			render json: {}, status: :unauthorized
		end
	end

	def destroy
		@activeUser = User.find_by authentication_token: params[:token]

		if @activeUser&.admin?
			@seller = User.find(params[:id]) 
			@shop = Shop.find(@seller.shop_id)
			if @seller.destroy
				destroy_shop
				render json: {}, status: :ok
			end
		else
			render json: {}, status: :unauthorized
		end
	end

private 

	def destroy_shop
		@sellers = User.find_by shop_id: @shop.id

		if !@sellers
			@shop = Shop.find(@shop.id)
			@shop.destroy
		end
	end

end