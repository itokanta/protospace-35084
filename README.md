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

# テーブル設計

## usersテーブル

### Column
1. email
2. password
3. name
4. profile
5. occupation
6. position

### Type
1. string
2. string
3. string
4. text
5. text
6. text

### Options
1. null: false
2. null: false
3. null: false
4. null: false
5. null: false
6. null: false

### Association
- has_many :prototypes
- has_many :comments


## commentsテーブル

### Column
1. text
2. user
3. prototype

### Type
1. text
2. references
3. references

### Options
1. null: false
2. foreign_key: true
3. foreign_key: true

### Association
- belongs_to :user
- belongs_to :prototype


## prototypesテーブル

### Column
1. title
2. catch_copy
3. concept
4. image
5. user

### Type
1. string
2. text
3. text
4. ActiveStorage
5. references

### Options
1. null: false
2. null: false
3. null: false
4. 
5. foreign_key: true

### Association
- has_many :comments
- belongs_to :user