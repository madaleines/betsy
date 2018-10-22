class Order < ApplicationRecord
  has_many :order_items

  valid_cart_status = %w(cart paid complete)

  validates :status, presence: true
  validates :email, presence: true, uniqueness: true, unless cart_status
  validates :mailing_address, presence: true, unless cart_status
  validates :cc, presence: true, unless cart_status
  validates :cc_name, presence: true, unless cart_status
  validates :cc_expiration, presence: true, unless cart_status
  validates :cvv, presence: true, unless cart_status
  validates :zip, presence: true, unless cart_status

  def cart_status
    return self.status != 'cart'
  end
end
