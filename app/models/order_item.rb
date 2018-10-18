class OrderItem < ApplicationRecord
  has_many :products
  belongs_to :orders
end
