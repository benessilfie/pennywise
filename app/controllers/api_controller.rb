class ApiController < ActionController::Base
  include ErrorHandler
  skip_before_action :verify_authenticity_token, raise: false

  rescue_from StandardError, with: :error_handler
end
