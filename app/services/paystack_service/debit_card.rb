class PaystackService::DebitCard
  include HTTParty
  base_uri 'https://api.paystack.co'

  def self.headers
    {
      'Authorization' => "Bearer #{ENV['PAYSTACK_SECRET_KEY']}",
      'Content-Type' => 'application/json'
    }
  end

  def self.charge(transaction:, card: nil, authorization: nil, pin: nil)
    body = {
      email: transaction.user.email,
      amount: transaction.amount,
      reference: transaction.transaction_reference
    }.merge(card || {}).merge(authorization || {}).merge({ pin: } || {})

    post('/charge', body: body.to_json, headers:)
  end

  def self.submit_pin(transaction:, pin:)
    body = {
      pin:,
      reference: transaction.transaction_reference
    }

    post('/charge/submit_pin', body: body.to_json, headers:)
  end

  def self.submit_otp(transaction:, otp:)
    body = {
      otp:,
      reference: transaction.transaction_reference
    }

    post('/charge/submit_otp', body: body.to_json, headers:)
  end
end
