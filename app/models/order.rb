class Order < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :btc_amount, :rate,  :dollar_amount
  validate :check_math, :check_balance
  private
  def check_math
    errors.add(:math_error, "Your math is wrong") unless
        self.dollar_amount.to_f / self.rate.to_f == self.btc_amount.to_f
  end
  def check_balance
    user = User.find(self.user_id)
    errors.add(:bitcoin_balance_error, "Insufficient Bitcoin") if self.btc_amount.to_f > user.btc_balance.to_f
    errors.add(:dollar_balance_error, "Insufficient Dollars") if self.dollar_amount.to_f > user.usd_balance.to_f
  end
end
