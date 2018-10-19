class Review < ApplicationRecord
  belongs_to :product


  validates_associated :product
  validates :rating, presence: true
  validates :rating, numericality: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, :numericality => { :less_than_or_equal_to => 5, :greater_than_or_equal_to => 1 }
  validates :description, presence: true
end
