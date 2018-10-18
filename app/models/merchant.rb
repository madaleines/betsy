class Merchant < ApplicationRecord
  has_many :products
  has_many :order_items through :product
end
