class Product < ApplicationRecord
  belongs_to :merchant
  has_and_belongs_to_many :categories
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
<<<<<<< HEAD

  validates :name, presence: true, uniqueness: true
=======
>>>>>>> e2266a2dd3d84c282ef83f0e6ae345026c66227c

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  validates_numericality_of :inventory, :only_integer => true, :greater_than_or_equal_to => 0
end
