class Api::DebitCardsController < ApiController
  include PinOtpSendable
  include DebitCardHelper
  before_action :set_wallet

  def create
    transaction = @wallet.make_credit(100, save: false, skip_source_validation: true)
    response = PaystackService::DebitCard.charge(transaction:, card: debit_card_params)

    paystack_response(response)
  end

  def destroy
    current_user.debit_cards.find(params.require(:id))&.destroy
    render json: { message: 'Debit card deleted successfully' }, status: :ok
  end

  private

  def debit_card_params
    params.permit(card: %i[number cvv expiry_month expiry_year]).to_h
  end
end
