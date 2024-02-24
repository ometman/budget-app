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
    @deals = []
    deal_params[:category_ids].each do |category_id|
      deal = Category.find(category_id).deals.build(deal_params.except(:category_ids))
      deal.user = current_user

      @deals << deal if deal.save
    end
  
    if @deals.any?
      redirect_to user_category_deals_path(current_user, @category), notice: 'Deals were successfully created.'
    else
      flash.now[:alert] = 'Failed to create deals.'
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
    if @deal.destroy
      redirect_to user_category_deals_path, notice: 'Deal was successfully destroyed.'
    else
      redirect_to user_category_deals_path, alert: 'Failed to destroy category.'
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_deal
    @deal = current_user.deals.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:name, :amount, category_ids: [])
  end
end
