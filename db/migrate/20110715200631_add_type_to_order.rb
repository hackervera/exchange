class AddTypeToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :type, :string
  end

  def self.down
    remove_column :orders, :type
  end
end
