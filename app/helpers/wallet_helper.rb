module WalletHelper
  def wallet = current_user.wallet

  def charge_debit_card(debit_card, transaction)
    PaystackService::DebitCard.charge(transaction:,
                                      authorization_code: { authorization_code: debit_card.authorization_code })
  end

  def paystack_response(response)
    case response['data']['status']
    when 'success'
      handle_response(@transaction, @transaction.amount)
    when 'false'
      @transaction.update!(status: :failed)
      raise StandardError, response['message']
    else
      render json: { errors: response['data'] }, status: :unprocessable_entity
    end
  end

  def handle_response(transaction, amount)
    ActiveRecord::Base.transaction do
      transaction.update!(status: :success)
      wallet.update!(balance: wallet.balance + amount)

      render json: {
        message: 'Wallet credited successfully',
        data: wallet.response
      }, status: :ok
    end
  end

  def set_transaction
    @transaction = Transaction.find_by!(transaction_reference: params.require(:reference))
    render json: { errors: ['Transaction not found'] }, status: :not_found unless @transaction
  end
end
