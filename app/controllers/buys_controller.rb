class BuysController < ApplicationController
  before_action :authenticate_user!
  def index
    @item = Item.find(params[:item_id])
    @buy_address = BuysAddresses.new
  end

  def create
    @buy_address = BuysAddresses.new(buy_params)
    @item = Item.find(params[:item_id])
    if @buy_address.valid?
      @buy_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buy_params
    params.require(:buys_addresses).permit(:post_number, :prefecture_id, :city, :house_number, :building_name,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
