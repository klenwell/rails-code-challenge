class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def authenticate
    unless signed_in?
      redirect_to auth_confirm_path
    end
  end
end
