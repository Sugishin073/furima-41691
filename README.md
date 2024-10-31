# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column           | Type       | Options                        |
| ------           | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false,                   |
| status_id        | integer    | null: false,                   |
| shipping_fee_id  | integer    | null: false,                   |
| prefecture_id    | integer    | null: false,                   |
| waiting_date_id  | integer    | null: false,                   |
| price            | integer    | null: false,                   |

### Association

- has_one    :buy
- belongs_to :user

## buys テーブル

| Column    | Type       | Options                        |
| -------   | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------        | ---------- | ------------------------------ |
| buy           | references | null: false, foreign_key: true |
| post_number	  | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false,                   |
| house_number  | string     | null: false,                   |
| building_name | string     |                                |
| phone_number  | string     | null: false,                   |

### Association

- belongs_to :buy