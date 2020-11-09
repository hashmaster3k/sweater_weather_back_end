Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'weather#index'
      get '/backgrounds', to: 'background#show'
      get '/trails', to: 'trails#index'
    end
  end
end
