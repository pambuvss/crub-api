class User < ApplicationRecord
	acts_as_token_authenticatable

	belongs_to :shop, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :confirmable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	
	enum role: [:customer, :seller, :admin]
	
	after_initialize :set_default_role, :if => :new_record?

	def set_default_role
		self.role ||= :customer
	end

	def as_json(_opts = {})
    if self.seller?
    {
      id: id,
      email: email,
      role: role,
      authentication_token: authentication_token,
      shop: shop.name 
    }
    else
    {
      id: id,
      email: email,
      role: role,
      authentication_token: authentication_token, 
    }
    end
  end

end
