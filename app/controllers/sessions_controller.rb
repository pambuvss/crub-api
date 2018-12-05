class SessionsController < ApplicationController

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

end