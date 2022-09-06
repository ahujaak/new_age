class PaymentMethod < ApplicationRecord
  belongs_to :driver

  enum method_type: { credit_card: 0, debit_card: 1, account: 2 }

  validates :card_number, presence: true, uniqueness: true, if: -> { ['credit_card', 'debit_card'].include?(method_type) }
  validates :account_number, presence: true, uniqueness: true, if: -> { method_type == 'account' }
  validates_presence_of :ifsc, :bank_name, if: -> { method_type == 'account' }

  scope :verified, -> { where(verified: true) }
  scope :default, -> { where(default: true) }

  def verified?
    verified
  end
end
