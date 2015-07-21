module SessionsHelper
  def sign_in(auth_token)
    session[:auth_token] = auth_token
    redirect_to root_path
  end

  def signed_in?
    true if session[:auth_token]
  end

  def sign_out
    session[:auth_token] = nil
  end
end
