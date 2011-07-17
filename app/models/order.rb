class Order < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :btc_amount, :rate,  :dollar_amount
end
