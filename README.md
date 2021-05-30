# アプリケーション名
**『フリマ』**

# アプリケーション概要
フリーマーケットサービスの模写です。独自に機能を拡張しました。

# URL
https://furima-35018.herokuapp.com/

# テスト用アカウント
出品者： aa@aa / aaaa1111 
購入者： ss@ss / aaaa1111
でログインをお願いします
新規ユーザー作成をしていただいても構いません

# 利用方法
まずユーザー認証をする必要があります。新規登録・ログイン・ゲストログインから選び、認証を進めてください。
ログインが完了すると、全ての機能を使用する事ができます

## 商品の出品
![13c7b3ec057462b9dd64631c48be9e2e](https://user-images.githubusercontent.com/80019801/120106335-92ad8580-c197-11eb-8f7a-ad3156a6a1d2.gif)
画面右下のボタンから商品の出品ができます
入力項目は全て記入必須となりますのでご注意ください

## 商品一覧
トップページには出品されている商品が全て表示されています
クリックすると商品の詳細ページへ遷移します

## 検索 ※NEW
![21e028239dc454d1bef9aa039007490d](https://user-images.githubusercontent.com/80019801/120106448-eddf7800-c197-11eb-9c28-7286bd2e5147.gif)
![ba2790f364d54822b3ee70446030dec3](https://user-images.githubusercontent.com/80019801/120106506-1d8e8000-c198-11eb-9e01-03c2ceee0717.gif)
ヘッダー部のフォームにキーワードを入力すると、曖昧検索が可能です
表示される商品は、商品名との一致についてです
ヘッダーのカテゴリに触れると商品のカテゴリー別に表示を切り替えることができます
検索をする際には在庫0の売り切れ商品は表示されません

## 商品の詳細表示
![a67abbd9e0afeca57ddaccb38708d6eb](https://user-images.githubusercontent.com/80019801/120106546-5595c300-c198-11eb-810f-66a8aeeb80a9.gif)
トップページから気になる商品をクリックすると、その商品の詳細ページへ遷移します。
購入する際はまずカートに商品の個数を追加してください
その後マイページから購入へ進むことができます

## カート ※NEW
![5036b0c6472cb0302f24f7747ce04929](https://user-images.githubusercontent.com/80019801/120106583-9097f680-c198-11eb-8c95-311687ce0284.gif)
![61d1112304a1d8942798ce347cd3e5f2](https://user-images.githubusercontent.com/80019801/120107895-bb387e00-c19d-11eb-9b58-8e1e5c7653cd.gif)
欲しい商品は、欲しい個数をカートに追加することができます
カートに入れている商品はマイページから確認が可能です

## 商品の購入
![da741d58f29ae2c66f780dc3a92d0272](https://user-images.githubusercontent.com/80019801/120108033-5893b200-c19e-11eb-94b5-b24621e2a94a.gif)
マイページ>カートに入れている商品>購入へ進む とボタンを押していくと商品の購入画面へ遷移します

## クレジットカードの登録 ※NEW
![499b761f73c24e1c57f4e947c4ad6a64](https://user-images.githubusercontent.com/80019801/120107968-12d6e980-c19e-11eb-95eb-46a86c9ecafd.gif)
商品を購入するためにはクレジットカードを登録する必要があります
登録前に購入画面へ進むと、自動的にカード登録画面へ遷移します

## 販売済み商品の管理 ※NEW
![c62fc35233b15e04134639fb46e23c2d](https://user-images.githubusercontent.com/80019801/120108186-0901b600-c19f-11eb-96b4-70a2e6e61945.gif)
販売した商品は、マイページ > 販売済み商品 > とクリックすると販売済み商品の詳細画面に遷移できます
ここから配送先情報を確認することが可能です

## 在庫の補充 ※NEW
![2b0c10cb5e66ada94368ce1b3891723a](https://user-images.githubusercontent.com/80019801/120108274-685fc600-c19f-11eb-8113-87d7e37d3e2e.gif)
出品した商品は、商品詳細ページ > 編集する > とクリックすると在庫を補充することができます




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
| Column         | Type       | Options                       |
| -------------- | ---------- | ------------------------------|
| name           | string     | null: false                   |
| desc           | text       | null: false                   |
| price          | integer    | null: false                   |
| user           | references | null: false foreign_key: true |
| category_id    | integer    | null: false                   |
| status_id      | integer    | null: false                   |
| shippingfee_id | integer    | null: false                   |
| prefecture_id  | integer    | null: false                   |
| esd_id         | integer    | null: false                   |



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
| prefecture_id | integer    | null: false                   |
| city          | string     | null: false                   |
| house_number  | string     | null: false                   |
| building_name | string     |                               |
| phone_number  | string     | null: false                   |
| order         | references | null: false foreign_key: true |

### Association
- belongs_to: order
