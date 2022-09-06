class Order < ApplicationRecord
  has_many :order_adjustments
  belongs_to :driver
  belongs_to :payment_method

  validate :has_verified_payment_method?
  # there must be atleast one verified payment method before placing an order
  validate :has_default_payment_method?
  validates_numericality_of :fuel_quantity, greater_than: 0.0
  validates_numericality_of :price, greater_than: 0.0

  before_save :calculate_total_amount
  after_save :update_driver_paylater_limit
  
  enum status: { pending: 0, in_progress: 1, completed: 2 }

  private

  def has_verified_payment_method?
    return if payment_method.verified?
    errors.add(:base, "can't place an order without verified payment method")
  end

  def has_default_payment_method?
    return if driver.payment_methods.default.blank?
    errors.add(:base, "can't place an order without default payment method")
  end

  def calculate_total_amount
    self.total_amount = fuel_quantity * price
  end

  def update_driver_paylater_limit
    updated_limit = driver.used_paylater_amount + total_amount
    self.driver.update(used_paylater_amount: updated_limit)
  end
end
