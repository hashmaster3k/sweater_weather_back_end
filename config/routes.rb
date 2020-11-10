Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'weather#index'
      get '/backgrounds', to: 'background#show'

      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trip, only: [:create]
    end
  end
end
