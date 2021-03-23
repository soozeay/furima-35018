# README

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

## users テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |


### Association
- has_many: items
- has_many: orders
- has_many: comments


## items テーブル
| Column          | Type       | Options                       |
| --------------- | ---------- | ------------------------------|
| name            | string     | null: false                   |
| desc            | text       | null: false                   |
| price           | integer    | null: false                   |
| user            | references | null: false foreign_key: true |
| category_id     | integer    | null: false                   |
| status_id       | integer    | null: false                   |
| shipping_fee_id | integer    | null: false                   |
| prefecture_id   | integer    | null: false                   |
| esd_id          | integer    | null: false                   |



### Association
- belongs_to: user
- has_one: order
- has_many: comments


## comments テーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| comment | text       | null: false                   |
| user    | references | null: false foreign_key: true |
| item    | references | null: false foreign_key: true |

### Association
- belongs_to: user
- belongs_to: item



## orders テーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| user    | references | null: false foreign_key: true |
| item    | references | null: false foreign_key: true |

### Association
- belongs_to: item
- belongs_to: user
- has_one: address



## addresses テーブル
| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| postal_code   | string     | null: false                   |
| city          | string     | null: false                   |
| house_number  | string     | null: false                   |
| building_name | string     |                               |
| phone_number  | string     | null: false                   |
| order         | references | null: false foreign_key: true |

### Association
- belongs_to: order
