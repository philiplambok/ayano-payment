Rails.application.routes.draw do
  namespace :api do 
    resources :roles
  end
end
