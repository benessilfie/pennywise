module Authenticable
  def current_user
    return @current_user if @current_user

    decoded = decode_token
    @current_user ||= User.find(decoded[:user_id])
  end

  def check_user
    return if @user&.id == current_user&.id

    render json: { errors: ['You are not authorized to perform this action'] },
           status: :unauthorized
  end

  def set_user
    @user = User.find(params[:id])
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
