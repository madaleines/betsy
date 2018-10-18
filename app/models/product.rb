class Product < ApplicationRecord
  belongs_to :merchants
  has_and_belongs_to_many :categories
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
