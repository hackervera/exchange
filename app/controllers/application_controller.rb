class ApplicationController < ActionController::Base
  include Clearance::Authentication
  before_filter :authorize, :load_config
  def load_config
    @config = CONFIG
    auth = "/oauth.ashx"
    @consumer = OAuth::Consumer.new(@config['dwolla_key'], @config['dwolla_secret'],
                                    site: "https://www.dwolla.com/oauth",
                                    callback_url: "http://www.postbin.org/q0q8qw",
                                    request_token_path: auth,
                                    authorize_path: auth,
                                    access_token_path: auth ,
                                    http_method: :get

    )
    @request_token = @consumer.get_request_token(scope: "AccountAPI:balance")
    @access_token = OAuth::AccessToken.new @consumer



  end
    #protect_from_forgery



end
