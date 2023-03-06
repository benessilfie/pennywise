class Api::WalletsController < ApiController
  include PinOtpSendable
  include WalletHelper

  before_action :set_transaction, only: %i[send_pin send_otp]

  def show
    render json: wallet.response, status: :ok
  end

  def credit
    amount = params.require(:amount).to_f
    debit_card = current_user.debit_cards.find(params.require(:card_id))

    @transaction = wallet.make_credit(amount, source: debit_card)
    response = charge_debit_card(debit_card, @transaction)

    paystack_response(response)
  end
end
