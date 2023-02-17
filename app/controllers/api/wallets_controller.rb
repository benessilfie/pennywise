class Api::WalletsController < ApiController
  def show
    render json: current_user.wallet.response, status: :ok
  end
end
