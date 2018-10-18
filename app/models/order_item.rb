class OrderItem < ApplicationRecord
  has_many :products
  belongs_to :order
  has_one :merchant, through: :product
end
