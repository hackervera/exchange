class ApplicationController < ActionController::Base
  include Clearance::Authentication
  before_filter :authorize

    #protect_from_forgery



end
