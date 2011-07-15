class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.string :btc_amount
      t.string :dollar_amount
      t.string :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
