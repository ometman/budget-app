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
    render file: "./public/404.html", status: :not_found
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
    render_404
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
