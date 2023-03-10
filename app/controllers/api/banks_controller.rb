class Api::BanksController < ApiController
  before_action :current_user

  def show
    bank_list = PaystackService::Utility.banks
    bank_data = bank_list['data'].map { |bank| bank.slice('code', 'name', 'slug') }

    render json: {
      message: 'Banks retrieved successfully',
      data: bank_data
    }
  end
end
