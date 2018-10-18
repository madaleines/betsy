class Product < ApplicationRecord
  has_many :order_items
  has_many :reviews
  belongs_to :merchants
end
