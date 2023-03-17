module BankAccountHelper
  def parse_recipient(response)
    case response['status']
    when false
      raise StandardError, message: response['message']
    when true
      result = { recipient_code: response['data']['recipient_code'] }
      result.merge(response['data']['details'].slice('account_number', 'account_name', 'bank_name', 'bank_code'))
    end
  end

  def parse_account(response)
    case response['status']
    when false
      raise StandardError, message: response['message']
    when true
      response['data']['account_name']
    end
  end

  def bank_account_response(bank_account)
    {
      message: 'Bank account succesfully verified',
      data: {
        id: bank_account.id,
        account_number: bank_account.account_number,
        bank_name: bank_account.bank_name,
        account_name: bank_account.account_name,
        recipient_code: bank_account.recipient_code
      }
    }
  end

  def bank_account_already_verified(bank_account)
    render json: bank_account_response(bank_account)
  end
end
