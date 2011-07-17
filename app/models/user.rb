class User < ActiveRecord::Base

  has_many :orders
  include Clearance::User
  serialize :pending
end
