class BalancesController < ApplicationController
  def show


  end

  def edit
    @balance = Balance.new({:current_balance => current_user.usd_balance})
  end

  def update
    Rails.logger.info params[:balance]
  end

  def create
      Rails.logger.info "PARAMAZAN #{params[:balance]}"
      @balance = Balance.new(params[:balance])
      Rails.logger.info "Valid? #{@balance.valid?}; Balance: #{@balance.inspect}"
      params[:id] = "withdraw"
    unless @balance.valid?
      render :action => :edit
    end
  end

  def generate_id
    respond_to do |format|
      format.js do
        h = ServiceProxy.new CONFIG["bitcoin_daemon"]
        pending = h.getnewaddress.call
        unless current_user.pending.class == Array
          current_user.pending = []
        end
        current_user.pending << pending
        current_user.save
        render :json => pending.to_json
      end
    end

  end
end
