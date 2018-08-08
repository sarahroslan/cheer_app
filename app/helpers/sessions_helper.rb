module SessionsHelper

	#Signs in the user

	def sign_in(user)
		session[:user_id] = user.id
	end

	#Returns the current user if any

	def current_user
		@current_user ||= User.find_by(id:session[:user_id])
	end
end
