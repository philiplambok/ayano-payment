Rails.application.routes.draw do
  namespace :api do 
    resources :auth, only: [:create]

    resources :roles
    
    resources :users do 
      member do 
        get 'role'
      end
    end
  end
end
