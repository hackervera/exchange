class Order < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :btc_amount, :rate,  :dollar_amount
  validate :check_math
  private
  def check_math
    errors.add(:math, "Your math is wrong") unless
        self.dollar_amount.to_f / self.rate.to_f == self.btc_amount.to_f
  end
end
