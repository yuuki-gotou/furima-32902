class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :set_root, only: [:index, :create]

  def index
    @item_purchase_record = PurchaseRecordAddress.new
  end

  def create
    @item_purchase_record = PurchaseRecordAddress.new(purchase_record_params)
    if @item_purchase_record.valid?
      pay_item
      @item_purchase_record.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_record_params
    params.require(:purchase_record_address).permit(:postal_code, :delivery_source_id, :municipality, :house_number, :building_name, :telephone_number).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end

  def set_root
    if current_user.id != @item.user_id && @item.purchase_record == nil
    else
      redirect_to root_path
    end
  end
end
