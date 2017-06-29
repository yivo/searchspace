class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

protected
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
