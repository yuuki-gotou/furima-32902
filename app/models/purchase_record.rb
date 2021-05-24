class PurchaseRecord < ApplicationRecord
  belongs_to :item
  has_one :address
  belongs_to :user
end
