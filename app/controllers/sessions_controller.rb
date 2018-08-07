class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
       redirect_to root_path, :notice => "Welcome back, #{user.email}"
    else
      redirect_to new_session_path, :notice => "Couldn't find you." 
    # If user's login doesn't work, send them back to the login form.
      
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/sign_in'
  end
end
