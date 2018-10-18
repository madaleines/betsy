class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  has_one :merchant, through: :product
end
