class User < ActiveRecord::Base

  has_many :orders
  serialize :pending
end
