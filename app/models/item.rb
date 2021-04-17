class Item < ApplicationRecord
  extend ActiveHash::Associations::ApplicationRecordExtensions
  has_one :purchase_record
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :delivery_source
  belongs_to :day_to_ship
  
  with_options presence: true do
    validates :name, :description, :image

    with_options numericality: { other_than: 1 } do
      validates :delivery_source_id, :category_id, :condition_id, :delivery_fee_id, :delivery_source_id, :day_to_ship_id
    end

    with_options format: { with: /\A[0-9]+\z/ } do
      validates :price, numericality: { greater_than: 300, less_than: 9999999 }
    end
  end
end