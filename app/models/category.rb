class Category < ApplicationRecord
  has_and_belongs_to_many :products

  CATEGORIES = %w(toys books meditation apparel)

  validates_associated :products
  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
