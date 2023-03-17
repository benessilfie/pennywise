class Api::BankAccountsController < ApiController
  include BankAccountHelper
  before_action :current_user

  def verify
    bank_account = BankAccount.find_by(**account_params)
    return bank_account_already_verified(bank_account) if bank_account

    paystack_response = PaystackService::Utility.resolve_account_number(**account_params)
    account_name = parse_account(paystack_response)
    recipient_response = parse_recipient(PaystackService::Utility.transfer_recipient(account_name:, **account_params))

    bank_account = BankAccount.create!(**recipient_response)
    render json: bank_account_response(bank_account)
  end

  def account_params
    { account_number: params.require(:account_number), bank_code: params.require(:bank_code) }
  end
end
