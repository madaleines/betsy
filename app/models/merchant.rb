class Merchant < ApplicationRecord
  has_many :products
  has_many :order_items, through: :product

    validates :username, presence: true, uniqueness: true

    validates :email, presence: true, uniqueness: true
end
