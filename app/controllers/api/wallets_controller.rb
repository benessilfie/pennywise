class Api::WalletsController < ApiController
  include PinOtpSendable
  include WalletHelper

  before_action :set_transaction, only: %i[send_pin send_otp]
  before_action :set_destination, only: %i[transfer]

  def show
    render json: wallet.response, status: :ok
  end

  def credit
    amount = params.require(:amount).to_f
    debit_card = current_user.debit_cards.find(params.require(:card_id))

    @transaction = wallet.make_credit_transaction(amount, source: debit_card)
    response = charge_debit_card(debit_card, @transaction)

    paystack_response(response)
  end

  def transfer
    amount = params.require(:amount).to_f
    reason = params.require(:reason) || 'Transfer'

    return render json: { errors: ['Insufficient balance'] }, status: :bad_request if amount > wallet.balance
    return render json: { errors: ['Invalid destination'] }, status: :bad_request if wallet == @destination

    @transaction = wallet.make_debit_transaction(amount, destination: @destination)

    # We need to be registered as a merchant on Paystack to use this feature
    PaystackService::Transfer.initiate(transaction: @transaction, reason:)

    render json: { message: 'Your transaction is pending' }, status: :ok
  end
end
