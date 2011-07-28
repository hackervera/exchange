class SessionsController < ApplicationController
  def destroy
    session[:email] = nil
    redirect_to "/"
  end
end
