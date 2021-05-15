class PurchaseRecordAddress
  include ActiveModel::ActiveModel
  attr_accessor :user_id, :item_id, :postal_code, :delivery_source_id, :municipality, :house_number, :building_name, :telephone_number

  with_options presence: true do
    validates :municipality, :house_number
    validates :delivery_source_id, numericality: { other_than: 1 }
    validates :telephone_number, format: { with: /\A\d{11}\z/ }

    with_options format: { with: /\A\d{3}[-]\d{4}\z/ } do
      validates :postal_code, length: { is: 8 }
    end
  end

  def save
    user = User.create(nickname: nickname, email: email, encrypted_password: encrypted_password, last_name: last_name, first_name: first_name, kana_last_name: kana_last_name, kana_first_name: kana_first_name, birthday: birthday)
    item = Item.create(name: name, description: description, category_id: category_id, condition_id: condition_id, delivery_fee_id: delivery_fee_id, delivery_source_id: delivery_source_id, day_to_ship_id: day_to_ship_id, price: price)
    Address.create(postal_code: postal_code, delivery_source_id: delivery_source_id, municipality: municipality, house_number: house_number, building_name: building_name, telephone_number: telephone_number)
    PurchaseRecord.create(user_id: user_id, item_id: item_id)
  end
end