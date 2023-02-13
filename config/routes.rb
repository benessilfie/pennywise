Rails.application.routes.draw do
  namespace :api do
    resource :session, only: %i[create destroy]
    resource :user, only: %i[show create update]

    resource :wallet, only: %i[show]
  end
end
