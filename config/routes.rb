Rails.application.routes.draw do
  namespace :api do 
    resources :auth, only: [:create]
    get '/me', to: "auth#show"

    resources :roles
    
    resources :users do 
      member do 
        get 'role'
        get 'deposits', to: 'deposits#index'
        post 'deposits', to: 'deposits#create'
        post 'transaction', to: 'transaction#create'
        get 'logs', to: 'logs#index' 
      end
    end
  end
end
