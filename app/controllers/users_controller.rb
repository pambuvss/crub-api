class UsersController < ApplicationController

	before_action :cors_set_access_control_headers

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

	private
		def cors_set_access_control_headers
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = '*'
			headers['Access-Control-Request-Method'] = '*'
			headers['Access-Control-Allow-Headers'] = '*'
	  	end
end