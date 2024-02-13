class RegistrationsController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path, notice: "User successfully registered."
      else
        flash.now[:alert] = "Registration failed. Please fix the errors below."
        render :new
      end
    end
  end
  