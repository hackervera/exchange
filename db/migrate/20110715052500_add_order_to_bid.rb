class AddOrderToBid < ActiveRecord::Migration
  def self.up
    add_column :bids, :order_id, :integer
  end

  def self.down
    remove_column :bids, :order_id
  end
end
