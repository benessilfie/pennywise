class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token, raise: false

  include Authenticable
  include ErrorHandler

  rescue_from StandardError, with: :error_handler
end
