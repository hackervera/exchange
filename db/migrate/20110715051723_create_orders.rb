class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :btc_amount
      t.string :dollar_amount
      t.string :rate
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
