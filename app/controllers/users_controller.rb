class UsersController < ApplicationController

	def create
		@user = User.new(email: params[:email], password: params[:password], encrypted_password: params[:encrypted_password])
		if @user.save
			render json: {}, status: :created
		else 
			render json: {}, status: :bad_request
		end
	end

	def destroy

	end

end