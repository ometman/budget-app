class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[index show new create edit update destroy]

  def index
    @categories = current_user.categories.includes(:deals)
    @categories = if params[:oldest]
                    @categories.order(created_at: :asc)
                  else
                    @categories.order(created_at: :desc)
                  end
  end

  def show
    @category = Category.includes(:deals).find(params[:id])
    @deals = if params[:oldest]
               @category.deals.order(created_at: :asc)
             else
               @category.deals.order(created_at: :desc)
             end
  end

  def new
    @category = current_user.categories.build
    @deal = @category.deals.build
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to user_categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = current_user.categories.includes(:deals).find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
