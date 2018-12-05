class UsersController < ApplicationController

	def create
		@user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
		if @user.save
			render json: {}, status: :created
		else 
			render json: {}, status: :ok
		end
	end

	def destroy

	end

end