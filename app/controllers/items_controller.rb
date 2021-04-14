class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]
  def index
  end

  private

  def move_to_index
    redirected_to action: :index unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_fee_id, :delivery_source_id, :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end
end
