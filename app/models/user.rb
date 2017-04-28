class User < ApplicationRecord
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 30 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_insensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password

	# returns the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end