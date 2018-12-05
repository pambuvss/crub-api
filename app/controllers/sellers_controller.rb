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
			@user = User.new(email: params[:email], password: params[:password],
			 password_confirmation: params[:password_confirmation], shop: params[:shop],
			 role: 1)
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
			if @seller.destroy
				render json: {}, status: :ok
			end
		else
			render json: {}, status: :unauthorized
		end
	end
end