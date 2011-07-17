class BalancesController < ApplicationController
  def show


  end
  def generate_id
    respond_to do |format|
      format.js do
        h = ServiceProxy.new  CONFIG["bitcoin_daemon"]
        render :json => h.getnewaddress.call.to_json
      end
    end

  end
end
