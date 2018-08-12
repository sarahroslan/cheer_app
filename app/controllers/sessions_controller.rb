class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. 
      # This is how we keep the user signed in when they navigate around our website.
      #if sign in successful, send user to dashboard
       session[:user_id] = user.id
       redirect_to dashboard_path(user.id)
    else
      redirect_to sign_in_path
      flash[:notice] = "Couldn't find you. Please try again." 
    # If user's sign in doesn't work, send them back to the sign in form.
      
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path
  end

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
  
      if authentication.user
        user = authentication.user
        authentication.update_token(auth_hash)
        session[:user_id] = user.id
       redirect_to user_path(user.id)
        
      # else: user logs in with OAuth for the first time
      else
        user = User.create_with_auth_and_hash(authentication, auth_hash)
        # you are expected to have a path that leads to a page for editing user details
        @next = edit_user_path(user)
        @notice = "User created. Please confirm or edit details"
      end
  end
end
