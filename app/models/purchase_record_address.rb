class PurchaseRecordAddress

  include ActiveModel::Model
  attr_accessor  :token, :postal_code, :delivery_source_id, :municipality, :house_number, :building_name, :telephone_number, :user_id, :item_id, :purchase_record_id

  with_options presence: true do
    validates :municipality, :house_number, :token
    validates :delivery_source_id, numericality: { other_than: 1 }
    validates :telephone_number, format: { with: /\A\d{11}\z/ }

    with_options format: { with: /\A\d{3}[-]\d{4}\z/ } do
      validates :postal_code, length: { is: 8 }
    end
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, delivery_source_id: delivery_source_id, municipality: municipality, house_number: house_number, building_name: building_name, telephone_number: telephone_number, purchase_record_id: purchase_record.id)
  end
end