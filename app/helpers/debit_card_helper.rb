module DebitCardHelper
  def paystack_response(response)
    case response['data']['status']
    when 'success'
      debit_card = create_debit_card(response)
      render json: {
        message: 'Debit card successfully added',
        data: debit_card.as_json.except('authorization_code')
      }, status: :created
    when 'false'
      render json: { message: response['message'] }, status: :bad_request
    else
      render json: { errors: response['data'] }, status: :unprocessable_entity
    end
  end

  def set_wallet = @wallet = current_user.wallet

  def create_debit_card(response)
    DebitCard.find_or_create_by!(**response['data']['authorization']
      .slice('authorization_code', 'last4', 'exp_month', 'exp_year', 'card_type', 'bank'),
               user: current_user)
  end
end
