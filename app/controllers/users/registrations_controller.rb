class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(user_params)

    existing_user = User.find_by(email: @user.email)

    if existing_user
      flash.now[:alert] = 'Email already exists. Sign in or use a different email.'
      render 'new'
      return
    end

    if @user.save
      flash[:notice] = 'You have successfully registered. An email for confirmation will be sent shortly.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  # The path used after sign up.
  # path after registration
  def after_sign_up_path_for(_resource_or_scope)
    new_user_session_path # Redirect to login
  end

end
