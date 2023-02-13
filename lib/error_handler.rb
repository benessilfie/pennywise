module ErrorHandler
  def error_handler(error)
    case error
    when ActionController::ParameterMissing
      render json: { error: respond_with(error.message) }, status: :bad_request
    when ActiveRecord::RecordNotFound
      render json: { errors: ["User Record Not Found: No user found with ID: #{params[:id]}"] },
             status: :not_found
    when JWT::ExpiredSignature
      render json: { errors: ['Authentication Error: Token has expired'] }, status: :unauthorized
    when JWT::DecodeError
      render json: { errors: ['Authentication Error: Invalid or Missing token'] },
             status: :unauthorized
    else
      render json: { error: respond_with(error.message) },
             status: :internal_server_error
    end
  end

  def respond_with(message)
    case message
    when /empty: first_name/
      ['First name parameter is required and cannot be empty']
    when /empty: last_name/
      ['Last name parameter is required and cannot be empty']
    when /empty: email/
      ['Email parameter is required and cannot be empty']
    when /empty: password/
      ['Password parameter is required and cannot be empty']
    else
      ['An error has occurred on the server, please try again later']
    end
  end
end
