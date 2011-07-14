class HomeController < ApplicationController
  before_filter :authorize
  def index

  end

  def balance
    h = ServiceProxy.new('http://tyler:tyler@127.0.0.1:8332')
    logger.info "H: #{h}"
    @balance = h.getreceivedbyaccount.call 'tron'
    logger.info "@Balance: #{@balance.class}"
  end

end
