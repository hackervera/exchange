class UsersController < ApplicationController
  def create
     Rails.logger.info "Create params: #{params}"
    session[:assertion] = params[:assertion]
    session[:audience] = params[:audience]
  end
end
