class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
  redirect_to login_url
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
