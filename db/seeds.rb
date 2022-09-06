# frozed_string_literal: true

# create driver
puts "creating driver"
driver = Driver.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  paylater_limit: 1000.0
)

# create payment methods
puts "creating payment methods"
PaymentMethod.method_types.keys.each do |method_type|
  payment_method = PaymentMethod.new(
    method_type: method_type,
    driver_id: driver.id,
    verified: true
  )

  if %w(credit_card debit_card).include?(method_type)
    payment_method.card_number = Faker::Finance.credit_card
    payment_method.card_expriy = Faker::Business.credit_card_expiry_date
  else
    payment_method.account_number = Faker::Bank.account_number
    payment_method.bank_name = Faker::Bank.name
    payment_method.ifsc = Faker::Bank.swift_bic
  end

  payment_method.save!
end

# set default payment method
driver.payment_methods.first.update(default: true)