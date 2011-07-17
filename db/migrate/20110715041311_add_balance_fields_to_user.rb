class AddBalanceFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :btc_balance, :string
    add_column :users, :usd_balance, :string
  end

  def self.down
    remove_column :users, :usd_balance
    remove_column :users, :btc_balance
  end
end
