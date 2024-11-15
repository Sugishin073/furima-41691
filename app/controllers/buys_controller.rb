class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:create, :item_sold, :index]
  before_action :item_sold, only: [:index]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @buy_address = BuysAddresses.new
  end

  def create
    @buy_address = BuysAddresses.new(buy_params)
    if @buy_address.valid?
      pay_item
      @buy_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buy_params
    params.require(:buys_addresses).permit(:post_number, :prefecture_id, :city, :house_number, :building_name,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: buy_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def item_sold
    return unless current_user.id == @item.user_id || !@item.buy.nil?

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
