class ContentController < ApplicationController

	def index 
		if params.has_key?(:en)
			@data = File.read("#{Rails.root}/public/textEng.json")
			render :json => @data, status: :ok
		elsif params.has_key?(:ru)
			@data = File.read("#{Rails.root}/public/textRu.json")
			render :json => @data, status: :ok
		end
	end
	
end