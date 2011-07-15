class AddAssocToBid < ActiveRecord::Migration
  def self.up
    add_column :bids, :user_id, :int
  end

  def self.down
    remove_column :bids, :user_id
  end
end
