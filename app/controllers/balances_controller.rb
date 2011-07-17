class BalancesController < ApplicationController
  def show


  end
  def generate_id
    respond_to do |format|
      format.js do
        h = ServiceProxy.new  CONFIG["bitcoin_daemon"]
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
