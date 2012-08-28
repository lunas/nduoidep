class ApplicationController < ActionController::Base
  protect_from_forgery

  # If you want to ensure authorization happens on every action in your application, un-comment:
  # check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
