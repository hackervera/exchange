class HomeController < ApplicationController

  def index

  end

  def balance
    @title = "Your balance man!"
    #h = ServiceProxy.new('http://tyler:tyler@127.0.0.1:8332')
    #logger.info "H: #{h}"
    #@balance = h.getreceivedbyaccount.call 'tron'
    #logger.info "@Balance: #{@balance.class}"
  end

  def bid
    @title = "Make a bid, make it good!"
  end

  def withdraw

  end

end
