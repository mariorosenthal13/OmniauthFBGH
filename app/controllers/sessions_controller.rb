class SessionsController < ApplicationController
  #login

  def create
    #onmiauth middleware stores oauth data in the request ENV, not in params
    auth = request.env["omniauth.auth"]


    #if the user exists, log her in
    #else create user, and log her in
    # user = User.find_by(github_id: auth['uid'])
    # if user.nil?
    #   user = User.create_with_omniauth(auth)
    # end
    #### LONG WAY

      if auth['provider'] == "github"
        user = User.find_by(github_id: auth['uid']) ||
        User.create_from_github(auth)
      elsif auth['provider'] == "facebook"
        user = User.find_by(facebook_id: auth['uid']) ||
        User.create_from_facebook(auth)
      end

    session[:user_id] = user.id
    redirect_to root_url, notice: 'Signed in!'

  end

  # def create
  #
  #   auth = request.env["omniauth.auth"]
  #
  #   user = User.find_by(facebook_id: auth['uid']) || User.create_from_facebook(auth)
  #
  #   session[:user_id] = user.id
  #   redirect_to root_url, notice: 'Signed in!'
  #
  # end





  #logout
  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed out!'
  end
end
