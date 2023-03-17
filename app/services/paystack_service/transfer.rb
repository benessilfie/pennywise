class PaystackService::Transfer
  include PaystackService::ApiUtils

  def self.initiate(transaction:, reason:, source: 'balance')
    body = {
      amount: transaction.amount,
      source:,
      reason:,
      reference: transaction.transaction_reference,
      recipient: transaction.destination.recipient_code
    }

    post('/transfer', body: body.to_json, headers:).parsed_response
  end
end
