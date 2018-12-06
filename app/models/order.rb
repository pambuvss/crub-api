class Order < ApplicationRecord
	belongs_to :user
	belongs_to :furniture_item

	enum status: [:during, :complete, :canceled]
	
	after_initialize :set_default_status, :if => :new_record?

	def set_default_status
		self.status ||= :during
	end
end
