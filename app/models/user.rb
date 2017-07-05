class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save 	:downcase_email
	before_create :create_activation_digest

	VALID_EMAIL_REGEX = /\A[\d\+\.a-z_-]+@[a-z]+\.[a-z.]+\z/i
	validates(:name,  		presence: 	true, 
												length: 		{ maximum: 50 } )
  validates :email, 		presence: 	true, 
  											length: 		{ maximum: 255 }, 
  											format: 		{ with: VALID_EMAIL_REGEX },
  											uniqueness: { case_sensitive: false }
	validates	:password, 	presence: 	true,
												length: 		{ minimum: 6 }
	has_secure_password

	# returns the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end	

	# returns a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# remembers a user in the database for use in persisten sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# returns true if the given token matches the digest
	# ENHANCED, now it has the fancy metaprogramming and two arguments
	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest") # so clever
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end

# ACCOUNT ACTIVATION

	# activates an account
	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
		# old two lines version:
		# update_attribute(:activated,		true)
		# update_attribute(:activated_at, Time.zone.now)
		# please note how the original one was, it had user
		# user.update_attribute(:activated,			true)
	end

	# sends activation email
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
		# the call for self used to be to @user
	end

# PASSWORD RESET
	# sets the password reset attributes
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# sends password reset email
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	private
		# creates and assigns the activation token and digest
		def create_activation_digest
			self.activation_token  = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

		# converts email to all lower-case
		def downcase_email
			# self.email = email.downcase
			email.downcase!
		end
end