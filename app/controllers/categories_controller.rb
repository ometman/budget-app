class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories
  end

  def self_most_recent
    @recent_categories = Category.most_recent
  end

  def self_oldest
    @oldest_categories = Category.oldest
  end

  def show
    @category = Category.find(params[:id])
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
      redirect_to user_categories_path, notice: 'Category was successfully created.'
    else
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
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
