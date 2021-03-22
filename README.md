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
| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |

### Association
- has_many: items
- has_many: addresses
- has_one: order through address


## items テーブル
| Column    | Type       | Options                       |
| --------- | ---------- | ------------------------------|
| item_name | string     | null: false                   |
| item_desc | text       | null: false                   |
| price     | integer    | null: false                   |
| user      | references | null: false foreign_key: true |

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
| price   | references | null: false foreign_key: true |

### Association
- belongs_to: item
- has_one: address



## addresses テーブル
| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| postal_code   | integer    | null: false                   |
| city          | string     | null: false                   |
| house_number  | string     | null: false                   |
| building_name | string     | null: false                   |
| phone_number  | integer    | null: false                   |
| user          | references | null: false foreign_key: true |

### Association
- belongs_to: user
- belongs_to: address
