class OrderAdjustment < ApplicationRecord
  belongs_to :order
  belongs_to :driver

  enum adjustment_type: { refund: 0, credit: 1 }
  # refund when overcharged and credit when under-charged

  after_create :update_driver_paylater_limit

  def update_driver_paylater_limit
    paylater_limit = if adjustment_type == "refund"
      driver.used_paylater_amount - amount
    else
      driver.used_paylater_amount - amount
    end

    self.driver.update(used_paylater_amount: paylater_limit)
  end
end
