class AddPendingToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :pending, :string
  end

  def self.down
    remove_column :users, :pending
  end
end
