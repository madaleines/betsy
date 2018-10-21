class Product < ApplicationRecord
  belongs_to :merchant
  has_and_belongs_to_many :categories
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  validates_numericality_of :inventory, :only_integer => true, :greater_than_or_equal_to => 0

  def self.currency(price)
    price *= 0.01
    return number_to_currency(price)
  end
end
