# README

## users  テーブル

| Column           | Type    | Options     |
| -----------------| ------- | ----------- |
| nickname         | string  | null: false |
| email            | string  | null: false |
| password         | string  | null: false |
| name             | string  | null: false |
| kana_pronouncing | string  | null: false |
| birthday         | integer | null: false |


### Association
- has_many :items
- has_many :purchase_records

## items  テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| name             | text       | null: false                    |
| description      | text       | null: false                    |
| category         | string     | null: false                    |
| condition        | string     | null: false                    |
| delivery_fee     | string     | null: false                    |
| delivery_source  | string     | null: false                    |
| days_to_ship     | string     | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association
- has_one :user
- belongs_to :purchase_record

## purchase_records  テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :addresses
- belongs_to :user

## addresses  テーブル

| Column           | Type    | Options     |
| -----------------| ------- | ----------- |
| postal_code      | integer | null: false |
| prefectures      | string  | null: false |
| municipality     | string  | null: false |
| house_number     | text    | null: false |
| building_name    | text    | null: false |
| telephone_number | integer | null: false |


### Association
- belonga_to :purchase_record

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
