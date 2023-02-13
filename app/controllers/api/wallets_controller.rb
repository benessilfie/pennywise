class Api::WalletsController < ApiController
  def show
    render json: current_user.wallet, status: :ok
  end
end
