class DealsController < ApplicationController
  before_action :set_category
  before_action :set_deal, only: %i[show edit update destroy]

  def index
    @deals = @category.deals.includes(:category).order(created_at: :asc)
  end

  def show; end

  def new
    @deal = @category.deals.build
  end

  def create
    @deal = @category.deals.build(deal_params)
    @deal.user = current_user
    if @deal.save
      redirect_to user_category_deals_path(current_user, @category), notice: 'Deal was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @deal.update(deal_params)
      redirect_to @deal, notice: 'Deal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @deal.destroy
    redirect_to deals_url, notice: 'Deal was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_deal
    @deal = current_user.deals.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:name, :amount, :category_id)
  end
end
