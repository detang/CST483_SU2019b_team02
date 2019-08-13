class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :itemId
      t.string :description
      t.integer :customerId
      t.decimal :price, precision: 10, scale: 2
      t.decimal :award, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
