Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: proc { [200, {}, ['pom-pets-api']] }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :update, :destroy]
      resources :projects, only: [:create, :update, :destroy]
    end
  end


end
