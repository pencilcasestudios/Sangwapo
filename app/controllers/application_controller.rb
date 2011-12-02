class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => AppConfig.http_basic_name, :password => AppConfig.http_basic_password unless Rails.env == "test"

  helper_method :current_user, :user_signed_in?

  before_filter :set_user_time_zone

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def sign_in_required
    unless current_user
      store_location
      flash[:notice] = t("controllers.application_controller.flash.sign_in_required")
      redirect_to sign_in_path
      return false
    end
  end
  
  def admin_required
    unless current_user && current_user.admin?
      flash[:warning] = t("controllers.application_controller.flash.admin_required")
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] =
    if request.get?
      request.fullpath
    else
      request.referer
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end
end
