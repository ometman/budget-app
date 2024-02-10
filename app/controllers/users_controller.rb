class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:categories).all
  end

  def show
    @user = User.includes(:categories).find(params[:id])
  end

  def create
    # create handled by devise
  end
end
