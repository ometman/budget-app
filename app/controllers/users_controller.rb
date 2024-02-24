class UsersController < ApplicationController
  def index
    if current_user
      redirect_to user_categories_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @categories = @user.categories
  rescue ActiveRecord::RecordNotFound
    render file: './public/404.html', status: :not_found
  end

  def destroy
    @user = User.find(params[:id])
    # Authorization check: Ensure current user can only destroy their own account
    unless current_user == @user
      head :forbidden
      return
    end

    @user.destroy
    redirect_to root_path, notice: 'User was successfully deleted.'
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError, 'Not Found'
  end

  private

  # Configure permitted parameters for Devise sign-up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
