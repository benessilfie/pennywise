module PaystackService::ApiUtils
  extend ActiveSupport::Concern

  included do
    include HTTParty
    base_uri 'https://api.paystack.co'

    def self.headers
      {
        'Authorization' => "Bearer #{ENV['PAYSTACK_SECRET_KEY']}",
        'Content-Type' => 'application/json'
      }
    end
  end
end
