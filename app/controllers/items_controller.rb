class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update]
  before_action :authenticate_user!, only: [:new, :edit]
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return unless current_user.id != @item.user_id

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :prefecture_id, :shipping_fee_id, :status_id, :waiting_date_id, :name,
                                 :description, :price, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @item = Item.find(params[:id])
  end
end
