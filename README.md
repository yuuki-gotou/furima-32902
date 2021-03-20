# README

## users  テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| kana_last_name     | string | null: false               |
| kana_first_name    | string | null: false               |
| birthday           | date   | null: false               |


### Association
- has_many :items
- has_many :purchase_records

## items  テーブル

| Column             | Type       | Options                        |
| -------------------| ---------- | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | string     | null: false                    |
| condition_id       | string     | null: false                    |
| delivery_fee_id    | string     | null: false                    |
| delivery_source_id | integer    | null: false                    |
| day_to_ship_id     | string     | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- has_one :purchase_record
- belongs_to :user

## purchase_records  テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- has_one :address
- belongs_to :user

## addresses  テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| delivery_source_id | integer    | null: false                    |
| municipality       | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     |                                |
| telephone_number   | string     | null: false                    |
| purchase_record    | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase_record