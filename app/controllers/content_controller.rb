class ContentController < ApplicationController

	before_action :cors_set_access_control_headers
	
	def index 
		if params.has_key?(:en)
			@data = File.read("#{Rails.root}/public/textEng.json")
			render :json => @data, status: :ok
		elsif params.has_key?(:ru)
			@data = File.read("#{Rails.root}/public/textRu.json")
			render :json => @data, status: :ok
		end
	end
		
	private
	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
		headers['Access-Control-Request-Method'] = '*'
		headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  	end

end