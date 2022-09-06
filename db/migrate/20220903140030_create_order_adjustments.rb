class CreateOrderAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :order_adjustments do |t|
      t.string    :adjustment_type, null: false
      t.decimal   :amount, null: false, default: 0.0
      t.text      :description
      t.references :order, foreign_key: true, null: false, index: true
      t.references :driver, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
