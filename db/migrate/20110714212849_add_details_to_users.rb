class AddDetailsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :balance, :string
  end

  def self.down
    remove_column :users, :balance
  end
end
