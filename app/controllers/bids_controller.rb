class BidsController < ApplicationController
  def show

  end
  def   index

  end
  def new

  end
  def destroy

  end
  def create
    current_user.bids.create(btc_amount: params[:btc_amount], rate: params[:rate], dollar_amount: params[:dollar_amount])
    redirect_to bids_path
  end

end
