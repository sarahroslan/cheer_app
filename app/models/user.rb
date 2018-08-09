class User < ApplicationRecord
	has_secure_password
	has_many :tasks
	has_many :authentications, dependent: :destroy
	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :email, presence: true, uniqueness: true

	def self.create_with_auth_and_hash(authentication, auth_hash)
  user = self.create!(
     name: auth_hash["info"]["name"],
     email: auth_hash["info"]["email"],
     password: SecureRandom.hex(10)

   )
   user.authentications << authentication
   return user
 end

 # grab google to access google for user data
 def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
 end


	
end
