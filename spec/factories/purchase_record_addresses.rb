FactoryBot.define do
  factory :purchase_record_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code        { '123-4567' }
    delivery_source_id { '2' }
    municipality       { '札幌市' }
    house_number       { '12-3' }
    building_name      { 'テックビル' }
    telephone_number   { '09012345678' }
  end
end
