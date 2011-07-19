require 'json'
require 'remit'
=begin

api = Remit::API.new(
  CONFIG['aws_access_key'],
  CONFIG['aws_access_secret'],
  true
)
Rails.logger.info api.inspect
request = Remit::InstallPaymentInstruction::Request.new(
  :payment_instruction => "MyRole == 'Recipient' orSay 'Role does not match';",
  :caller_reference => Time.now.to_i.to_s,
  :token_friendly_name => "Friendly Name For Your Token",
  :token_type => "Unrestricted"
)
Rails.logger.info request
install_recipient_response = api.install_payment_instruction(request)
install_recipient_response.token_id  # hold on to this

request = Remit::InstallPaymentInstruction::Request.new(
  :payment_instruction => "MyRole == 'Caller' orSay 'Role does not match';",
  :caller_reference => Time.now.to_i.to_s,
  :token_friendly_name => "TriggerFood Caller Token",
  :token_type => "Unrestricted"
)

install_caller_response = api.install_payment_instruction(request)
install_caller_response.token_id  # hold on to this



=end
