class Driver < ApplicationRecord
  has_many :payment_methods
  has_many :orders
  has_many :order_adjustments

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, uniqueness: true, format: { with: /\A^\+[1-9]{1,2}[0-9]{8,14}$\z/ }, allow_blank: true
  validates :first_name, presence: true
  validates_numericality_of :used_paylater_amount, less_than_or_equal_to: :paylater_limit

  before_create :assign_paylater_date

  def available_paylater_limit
    paylater_limit - used_paylater_amount
  end

  def reset_paylater_limit!
    self.update(used_paylater_amount: 0.0)
  end

  private

  def assign_paylater_date
    self.paylater_date = Time.zone.now + PAYLATER_DURATION
  end
end
