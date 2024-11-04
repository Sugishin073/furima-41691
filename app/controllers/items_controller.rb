class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create!(item_params)
    redirect_to '/'
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :prefecture_id, :shipping_fee_id, :status_id, :waiting_date_id, :name,
                                 :description, :price, :image).merge(user_id: current_user.id)
  end
end
