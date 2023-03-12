class Api::CallbacksController < ApiController
  def paystack
    event = params[:event]
    reference = params[:data][:reference]

    transaction = Transaction.find_by(transaction_reference: reference)
    return head(:ok) if transaction.blank?

    if event == 'transfer.success'
      transaction.success!
      source_wallet = transaction.source
      source_wallet.balance -= transaction.amount
      source_wallet.save!
    else
      transaction.failed!
    end

    head(:ok)
  end
end
