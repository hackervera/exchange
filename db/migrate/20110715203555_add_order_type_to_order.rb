class AddOrderTypeToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_type, :string
  end

  def self.down
    remove_column :orders, :order_type
  end
end
