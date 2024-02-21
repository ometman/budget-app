class UsersController < ApplicationController
  def index
    if current_user
      redirect_to user_categories_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to root_path, notice: 'User was successfully created.'
  #   else
  #     flash.now[:alert] = @user.errors.full_messages.join(', ')
  #     render :new
  #   end
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     flash[:notice] = "Registration successfully. An email for confirmation will be sent shortly."
  #     redirect_to root_path
  #   else
  #     render 'new'
  #   end
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.confirmation_email(@user).deliver_now
      flash[:notice] = 'You have successfully registered. An email for confirmation will be sent shortly.'
      redirect_to root_path
    else
      render 'new'
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
    # Authorization check: Ensure the current user can only destroy their own account
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

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation) # Adjust attributes as needed
  end
end
