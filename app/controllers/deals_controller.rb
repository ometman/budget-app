class DealsController < ApplicationController
    before_action :set_deal, only: [:show, :edit, :update, :destroy]
  
    def index
      @deals = current_user.deals
    end
  
    def show
    end
  
    def new
      @deal = current_user.deals.build
    end
  
    def create
      @deal = current_user.deals.build(deal_params)
      if @deal.save
        redirect_to @deal, notice: 'Deal was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
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
  
    def set_deal
      @deal = current_user.deals.find(params[:id])
    end
  
    def deal_params
      params.require(:deal).permit(:name, :amount, :category_id)
    end
  end
  