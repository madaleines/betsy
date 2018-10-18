class Order < ApplicationRecord
  has_many :order_items

  validates :email, presence: true
  validates :mailing_address, presence: true
  validates :cc, presence: true
  validates :cc_name, presence: true
  validates :cc_expiration, presence: true
  validates :cvv, presence: true
  validates :zip, presence: true
end
