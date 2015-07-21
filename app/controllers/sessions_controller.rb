class SessionsController < ApplicationController
  def new
    # Displays confirmation link
  end

  def create
    google_auth = request.env["omniauth.auth"]

    if google_auth
      auth_token = google_auth[:credentials][:token]
      sign_in auth_token
    else
      flash[:alert] = 'Authentication failed!'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
