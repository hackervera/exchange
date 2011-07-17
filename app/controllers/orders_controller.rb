class OrdersController < ApplicationController
  def show

  end
  def   index

  end
  def new
    mtgox_trades

  end
  def destroy

  end

  def mtgox_trades
    req = Typhoeus::Request.new("http://mtgox.com/code/data/getDepth.php", max_redirects: 3, follow_location: true)
    trade_data = nil
    req.on_complete do |res|
      trade_data  = JSON.parse(res.body)

    end
    hydra = Typhoeus::Hydra.new
    hydra.queue req
    hydra.run

    @trade_data = trade_data
  end

  def find_match(order)
    type = order.order_type
    if type == "bid"
      match = "ask"
      found_order = Order.order_type_equals(match).rate_less_than_or_equal_to(order.rate).btc_amount_greater_than_or_equal_to(order.btc_amount)
      found_order.each do |found_order|
        Rails.logger.info found_order.inspect
        other_user = User.find(found_order.user_id)
          #TODO take a percentage fee profit for exchange
        current_user.btc_balance =  current_user.btc_balance.to_f + order.btc_amount.to_f
        current_user.usd_balance = current_user.usd_balance.to_f - order.dollar_amount.to_f

        other_user.btc_balance =  other_user.btc_balance.to_f - order.btc_amount.to_f
        other_user.usd_balance = other_user.usd_balance.to_f + order.dollar_amount.to_f

        found_order.btc_amount =  found_order.btc_amount.to_f -    order.btc_amount.to_f
        found_order.dollar_amount =found_order.dollar_amount.to_f -    order.dollar_amount.to_f


        found_order.save
        if found_order.btc_amount <= 0
          found_order.destroy
        end
        current_user.save
        order.destroy

      end
    else
      match = "bid"
      found_order = Order.order_type_equals(match).rate_greater_than_or_equal_to(order.rate).btc_amount_greater_than_or_equal_to(order.btc_amount)
      found_order.each do |found_order|
        Rails.logger.info found_order.inspect
        other_user = User.find(found_order.user_id)
          #TODO take a percentage fee profit for exchange
        current_user.btc_balance =  current_user.btc_balance.to_f - order.btc_amount.to_f
        current_user.usd_balance = current_user.usd_balance.to_f + order.dollar_amount.to_f

        other_user.btc_balance =  other_user.btc_balance.to_f + order.btc_amount.to_f
        other_user.usd_balance = other_user.usd_balance.to_f - order.dollar_amount.to_f

        found_order.btc_amount =  found_order.btc_amount.to_f -    order.btc_amount.to_f
        found_order.dollar_amount =found_order.dollar_amount.to_f -    order.dollar_amount.to_f

        found_order.save
        if found_order.btc_amount <= 0
          found_order.destroy
        end
        current_user.save
        order.destroy

      end
    end

    logger.info found_order.inspect
    found_order
  end

  def create
    if params[:order_type] == "bid"
      current_user.usd_balance = current_user.usd_balance.to_f - params[:dollar_amount].to_f
    else
      current_user.btc_balance = current_user.btc_balance.to_f - params[:btc_amount].to_f
    end
    current_user.save
    order = current_user.orders.create(btc_amount: params[:btc_amount], rate: params[:rate], dollar_amount: params[:dollar_amount], order_type: params[:order_type])
    find_match(order)

    redirect_to orders_path
  end
end
