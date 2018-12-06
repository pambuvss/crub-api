class SessionsController < ApplicationController

	before_action :cors_set_access_control_headers

	def create
		user = User.where(email: params[:email]).first

		if user&.valid_password?(params[:password])
			render json: user.as_json(only: [:email, :role, :authentication_token]), status: :created
		else
			render json: {}, status: :ok
		end
	end

	def destroy

	end

	private
		def cors_set_access_control_headers
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
			headers['Access-Control-Request-Method'] = '*'
			headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	  	end
end