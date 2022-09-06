class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table   :payment_methods do |t|
      t.integer    :method_type
      t.string     :card_number
      t.date       :card_expriy
      t.string     :account_number
      t.string     :bank_name
      t.string     :ifsc
      t.boolean    :verified, default: false
      t.boolean    :default, default: false
      t.references :driver, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
