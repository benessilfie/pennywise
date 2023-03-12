Rails.application.routes.draw do
  namespace :api do
    resource :session, only: %i[create destroy]
    resource :user, only: %i[show create update]

    resource :wallet, only: %i[show] do
      post :credit
      post :transfer

      post :send_pin, path: 'credit/send_pin'
      post :send_otp, path: 'credit/send_otp'
    end

    resource :debit_card, only: %i[create destroy] do
      post :send_pin
      post :send_otp
    end

    resource :banks, only: %i[show]
    resource :bank_account, only: %i[] do
      post :verify
    end

    resource :callback, only: [] do
      post :paystack
    end
  end
end
