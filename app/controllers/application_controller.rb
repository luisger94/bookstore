class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in_user, :website_admin?

  before_action :require_login

  def logged_in_user
    unless session[:user_id].blank?
      User.find_by(id: session[:user_id])
    else
      nil
    end
  end

  def require_login
    unless logged_in_user
      redirect_to login_path
    end
  end

  def website_admin?
    logged_in_user and logged_in_user.website_admin
  end

end