class User < ApplicationRecord
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\d\+\.a-z_-]+@[a-z]+\.[a-z.]+\z/i
	validates(:name,  		presence: true, 
												length: { maximum: 50 } )
  validates :email, 		presence: true, 
  											length: { maximum: 255 }, 
  											format: { with: VALID_EMAIL_REGEX },
  											uniqueness: { case_sensitive: false }
	validates	:password, 	presence: true,
												length: { minimum: 6 }

	has_secure_password

	# returns the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end	

	# return a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end
end
                                                      BCrypt::Engine.cost