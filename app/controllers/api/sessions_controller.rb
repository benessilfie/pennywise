class Api::SessionsController < ApiController
  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      render json: {
        message: 'Login successful',
        data: @user.as_json.merge(auth_token: JsonWebToken.encode(user_id: @user.id))
      }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  def destroy
    destroy_user_session
    render json: { message: 'Logout successful' }, status: :ok
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
