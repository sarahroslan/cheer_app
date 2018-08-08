class User < ApplicationRecord
	has_secure_password
	has_many :tasks
	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :email, presence: true, uniqueness: true
	
end
