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
| Column          | Type   | Options                   |
| --------------- | ------ | ------------------------- |
| nickname        | string | null: false               |
| email           | string | null: false, unique: true |
| encrypted_password | string | null: false            |
| last_name       | string | null: false               |
| first_name      | string | null: false               |
| last_name_kana  | string | null: false               |
| first_name_kana | string | null: false               |

### Association
- has_many: items
- has_many: orders
- has_many: comments


## items テーブル
| Column           | Type       | Options                       |
| ---------------- | ---------- | ------------------------------|
| name             | string     | null: false                   |
| desc             | text       | null: false                   |
| price            | integer    | null: false                   |
| user             | references | null: false foreign_key: true |
| category_id      | integer    | null: false foreign_key: true |
| status_id        | integer    | null: false foreign_key: true |
| shipping_fee_id  | integer    | null: false foreign_key: true |
| prefecture_id    | integer    | null: false foreign_key: true |
| shipment_src_id  | integer    | null: false foreign_key: true |
| esd_id           | integer    | null: false foreign_key: true |



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
| prefecture_id | integer    | null: false foreign_key: true |

### Association
- belongs_to: order


## category(active_hash)
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| category | string | null: false |

### Association
- belongs_to: item

## status(active_hash)
| Column | Type   | Options     |
| ------ | ------ | ----------- |
| status | string | null: false |

### Association
- belongs_to: item

## shipping_fee(active_hash)
| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| shipping_fee | string | null: false |

### Association
- belongs_to: item

## shipment_src(active_hash)
| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| shipment_src | string | null: false |

### Association
- belongs_to: item

## esd(active_hash)
| Column | Type   | Options     |
| ------ | ------ | ----------- |
| est    | string | null: false |

### Association
- belongs_to: item

## prefecture(active_hash)
| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| prefecture | string | null: false |

### Association
- belongs_to: item
- belongs_to: address
