Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: %i[create destroy]
    resources :users, only: %i[show index create update]
  end
end
