class ApplicationController < ActionController::Base
  before_filter :check_auth, :current_user
  private
  def check_auth
    if params[:assertion].nil? && session[:email].nil?
      render 'users/sign_in'
    else
      if session[:email].nil?
        response = check_assert(params[:assertion], params[:audience])
        Rails.logger.info "Verification response: #{response.body}"
        formatted_response = JSON.parse(response.body)
        if formatted_response['status'] == 'okay'
          session[:email] = formatted_response['email']
        end
      end
    end
  end

  def check_assert(assertion, audience)
    Typhoeus::Request.post('https://browserid.org/verify', :params => {:assertion => assertion, :audience => audience})
  end

  def current_user
    if session[:email]
      @current_user = User.find_or_create_by_email(:email => session[:email], :usd_balance => 0, :btc_balance => 0)
    end
  end
end
