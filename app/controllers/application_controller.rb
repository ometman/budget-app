class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # check_authorization unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  # Enable CSRF protection to secure form submissions
  protect_from_forgery with: :exception

  # path after sign in or log in
  def after_sign_in_path_for(_resource)
    user_categories_path(current_user)
  end

  # path after sign out
  def after_sign_out_path_for(_resource_or_scope)
    root_path # Redirect to root
  end

  # # path after registration
  # def after_registration_path_for(_resource_or_scope)
  #   root_path # Redirect to root
  # end

  # path after confirmation
    # def after_confirmation_path_for(resource_name, resource)
    #   new_user_session_path # Redirect to login
    # end

  protected

  # Configure permitted parameters for Devise sign-up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
  end
end
