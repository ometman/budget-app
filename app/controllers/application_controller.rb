class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # check_authorization unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  # Enable CSRF protection to secure form submissions
  protect_from_forgery with: :exception

  # path after sign out
  def after_sign_out_path_for(_resource_or_scope)
    root_path || home_path # Redirect to home page after sign out
  end

  protected

  # Configure permitted parameters for Devise sign-up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
  end
end
