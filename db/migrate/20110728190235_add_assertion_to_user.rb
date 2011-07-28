class AddAssertionToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :assertion, :string
  end

  def self.down
    remove_column :users, :assertion
  end
end
