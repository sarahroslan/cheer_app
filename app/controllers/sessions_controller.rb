class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      sign_in user
      #if sign in successful, send user to profile page
       redirect_to user_path(user.id)
    else
      redirect_to '/sign_in' 
      flash[:notice] = "Couldn't find you. Please try again." 
    # If user's login doesn't work, send them back to the login form.
      
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/sign_in'
  end
end
