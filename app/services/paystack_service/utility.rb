class PaystackService::Utility
  include PaystackService::ApiUtils

  def self.banks
    get('/bank', headers:).parsed_response
  end

  def self.resolve_account_number(account_number:, bank_code:)
    query = { account_number:, bank_code: }.to_query

    get("/bank/resolve?#{query}", headers:).parsed_response
  end

  def self.transfer_recipient(account_number:, bank_code:, account_name:, type: 'nuban')
    body = {
      type:,
      currency: 'NGN',
      account_number:,
      name: account_name,
      bank_code:,
      description: "Transfer to #{account_name}"
    }

    post('/transferrecipient', body: body.to_json, headers:).parsed_response
  end
end
