class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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
      UserMailer.confirmation_email(@user).deliver_now
      flash[:notice] = 'You have successfully registered. An email for confirmation will be sent shortly.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
    # path after registration
    def after_sign_up_path_for(_resource)
      new_user_session_path # Redirect to login
    end

  # The path used after sign up for inactive accounts.
end
