class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  has_one :merchant, through: :product

  validates_associated :product, :order, :merchant
  validates :quantity, presence: true, :numericality => { only_integer: true, greater_than_or_equal_to: 1 }
  validates :status, presence: true
  validate :quantity_validation

  def quantity_validation
    if self.quantity > self.product.inventory
      self.errors.add(:quantity, " - Please order only what's available")
    end
  end

end
