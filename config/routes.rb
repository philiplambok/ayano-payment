Rails.application.routes.draw do
  namespace :api do 
    resources :roles
    resources :users
  end
end
