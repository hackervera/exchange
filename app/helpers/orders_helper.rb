module OrdersHelper

  def mtgox_trades
    req = Typhoeus::Request.new("http://mtgox.com/code/data/getDepth.php", max_redirects: 3, follow_location: true)
    trade_data = nil
    req.on_complete do |res|
      trade_data  = JSON.parse(res.body)

    end
    hydra = Typhoeus::Hydra.new
    hydra.queue req
    hydra.run


    @ask_gox = trade_data['asks'].sort.first
    @bid_gox = trade_data['bids'].sort.reverse.first
    ask = Order.find_all_by_order_type("ask", order: :rate)
    @ask = ask.each.first                       unless ask.nil?
    bid = Order.find_all_by_order_type("bid", order: "rate DESC")
    @bid = bid.each.first unless bid.nil?
  end
end
