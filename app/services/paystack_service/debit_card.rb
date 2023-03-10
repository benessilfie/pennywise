class PaystackService::DebitCard
  include PaystackService::ApiUtils

  def self.charge(transaction:, card: nil, authorization_code: nil, pin: nil)
    body = {
      email: transaction.user.email,
      amount: transaction.amount,
      reference: transaction.transaction_reference
    }.merge(card || {}).merge(authorization_code || {}).merge({ pin: } || {})

    post('/charge', body: body.to_json, headers:)
  end

  def self.submit_pin(reference:, pin:)
    body = {
      pin:,
      reference:
    }

    post('/charge/submit_pin', body: body.to_json, headers:)
  end

  def self.submit_otp(reference:, otp:)
    body = {
      otp:,
      reference:
    }

    post('/charge/submit_otp', body: body.to_json, headers:)
  end
end
