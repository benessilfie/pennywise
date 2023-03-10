class Api::BankAccountsController < ApiController
  before_action :current_user

  def verify
    paystack_response = PaystackService::Utility.resolve_account_number(**account_params)

    render json: paystack_response
  end

  def account_params
    { account_number: params.require(:account_number), bank_code: params.require(:bank_code) }
  end
end
