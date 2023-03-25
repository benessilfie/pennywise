class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token, raise: false

  include Authenticable
  include ErrorHandler

  rescue_from StandardError, with: :error_handler

  def home
    render json: {
      message: 'Welcome to the Pennywise API',
      info: "The interactive Swagger documentation is currently under development and will be available soon. In the meantime, you can refer to the API specification documentation on the GitHub project to learn more about the available endpoints, parameters, and response formats. If you have any questions or feedback, please don't hesitate to contact me via mail: bquansah007@gmail.com."
    }
  end
end
