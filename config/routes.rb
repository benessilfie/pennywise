Rails.application.routes.draw do
  namespace :api do
    resource :session, only: %i[create destroy]
    resource :user, only: %i[show create update]

    resource :wallet, only: %i[show] do
      post :credit
      post :debit
      post :transfer
    end

    resource :debit_card, only: %i[create destroy] do
      post :send_pin
      post :send_otp
    end
  end
end
