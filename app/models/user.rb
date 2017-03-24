class User < ApplicationRecord
	VALID_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name , presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_email_regex},
										uniqueness: { case_sensitive: false }
end
