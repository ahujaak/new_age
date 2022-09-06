class CreateDrivers < ActiveRecord::Migration[6.1]
  def change
    create_table :drivers do |t|
      t.string  :first_name, null: false
      t.string  :last_name
      t.string  :email, null: false, index: true
      t.string  :phone
      t.text    :address
      t.integer :paylater_limit, default: 0
      t.integer :used_paylater_amount, default: 0
      t.date    :paylater_date

      t.timestamps
    end
  end
end
