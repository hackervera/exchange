class Balance
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates_presence_of :dwolla_account, :amount
  validates_numericality_of :amount, :greater_than => 0
  attr_accessor :dwolla_account, :amount, :current_balance

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end