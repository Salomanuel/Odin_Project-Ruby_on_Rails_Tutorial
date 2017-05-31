class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\+\.a-z_-]+@[a-z]+\.[a-z.]+\z/i
	validates(:name,  presence: true, 
										length: { maximum: 50 } )
  validates :email, presence: true, 
  									length: { maximum: 255 }, 
  									format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }
end
