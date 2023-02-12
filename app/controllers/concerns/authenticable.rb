module Authenticable
  def current_user
    return @current_user if @current_user

    token = request.headers['Authorization'] & gsub('Bearer ', '')
    return render json: { errors: ['Invalid token'] }, status: :unauthorized if token.blank?

    decoded = JsonWebToken.decode(token)
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
end
