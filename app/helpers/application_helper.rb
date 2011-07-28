module ApplicationHelper
  class Dwolla
    attr_accessor :consumer, :access_token, :request_token

    def initialize
      @config = CONFIG

      auth = "/oauth/oauth.ashx"
      @consumer = OAuth::Consumer.new(@config['dwolla_key'], @config['dwolla_secret'],
                                      site: "https://www.dwolla.com",
                                      callback_url: "http://www.postbin.org/q0q8qw",
                                      request_token_path: auth,
                                      authorize_path: auth,
                                      access_token_path: auth,
                                      oauth_version: "1.0a"

      )
      @request_token = @consumer.get_request_token({}, scope: "AccountAPI:Balance|AccountAPI:AccountInformation")
      @access_token = OAuth::AccessToken.new @consumer


    end
  end

  class DwollaSoap
    attr_accessor :client

    def send_money(option_hash)
      @client.request :wsdl, :send_money do
        soap.body = {
            "wsdl:ApiKey" => @api_key,
            "wsdl:ApiCode" => @api_code,
            "wsdl:Amount" => option_hash[:amount],
            "wsdl:DestinationID" => option_hash[:to],
            "wsdl:Description" => option_hash[:description]
        }
        Rails.logger.info soap.inspect
      end
    end

    def initialize
      #dwolla_wsdl =  "https://www.dwolla.com/api/TestAPI.svc?wsdl"
      dwolla_wsdl = "https://www.dwolla.com/api/API.svc?wsdl"
      @client = Savon::Client.new do
        wsdl.document = dwolla_wsdl
        wsdl.endpoint = dwolla_wsdl

      end
      @api_key = CONFIG["dwolla_api_key"]
      @api_code = CONFIG["dwolla_api_code"]
    end
  end

  def dwolla
    Dwolla.new
  end

  def dwolla_soap
    DwollaSoap.new
  end




end
