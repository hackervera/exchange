CONFIG = YAML::load(File.open("#{RAILS_ROOT}/config/config.yml"))

class JSONRPCException < RuntimeError
  def initialize()
    super()
  end
end

class ServiceProxy
  def initialize(service_url, service_name=nil)
    @service_url = service_url
    @service_name = service_name
  end

  def method_missing(name, *args, &block)
    if @service_name != nil
      name = "%s.%s" % [@service_name, name]
    end
    return ServiceProxy.new(@service_url, name)
  end

  def respond_to?(sym)
  end

  def call(*args)
    postdata = {"method" => @service_name, "params" => args, "id" => "jsonrpc"}.to_json
    respdata = RestClient.post @service_url, postdata
    resp = JSON.parse respdata
    if resp["error"] != nil
      raise JSONRPCException.new, resp['error']
    end
    return resp['result']
  end
end

EM.next_tick do
  Rails.logger.info self.class
  h = ServiceProxy.new  CONFIG["bitcoin_daemon"]
  EM::PeriodicTimer.new(1000) do
    User.all.each do |user|
      next if user.pending.nil? || user.pending.class != Array
      user.pending.delete_if do |pending|
        delete = nil
        if h.getreceivedbyaddress.call(pending[0]).to_i >= pending[1]
           Rails.logger.info  "adding funds to #{user.email} because of #{pending[0]}"
           user.balance  = user.balance.to_i + pending[1]
           delete = true
        end
        delete == true
      end
      user.save
    end
    Rails.logger.info "PING!"
  end
end