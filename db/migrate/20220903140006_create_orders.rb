class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer    :status, null: false, default: 0
      t.decimal    :fuel_quantity, default: 0.0
      t.decimal    :price, default: 0.0
      t.decimal    :total_amount, default: 0.0
      t.boolean    :pay_later, default: true
      t.text       :comment
      t.references :payment_method
      t.references :driver, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
