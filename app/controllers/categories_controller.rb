class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
    if params[:oldest]
      @categories = @categories.order(created_at: :asc)
    else
      @categories.order(created_at: :desc)
    end
  end

  def show
    @category = current_user.categories.find(params[:id])
    if params[:oldest]
      @deals = @category.deals.order(created_at: :asc)
    else
      params[:recent]
      @deals = @category.deals.order(created_at: :desc)
    end
  end

  def new
    @category = current_user.categories.build
    @deal = @category.deals.build
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to user_categories_path(current_user), notice: 'Category was successfully created.'
    else
      flash.now[:alert] = 'Category creation failed.'
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to user_categories_path, notice: 'Category was successfully destroyed.'
    else
      redirect_to user_categories_path, alert: 'Failed to destroy category.'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
