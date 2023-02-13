module Authenticable
  def current_user
    return @current_user if @current_user

    decoded = decode_token
    @current_user ||= User.find(decoded[:user_id])
  end

  def destroy_user_session
    @current_user = nil
  end

  private

  def decode_token
    token = request.headers['Authorization']&.split&.last
    decoded = JsonWebToken.decode(token)

    raise JWT::DecodeError if decoded.nil?
    raise JWT::ExpiredSignature if Time.now.to_i >= decoded[:exp]

    decoded
  end
end
