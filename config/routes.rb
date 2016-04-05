Rails.application.routes.draw do
  root 'welcome#index'
  resources :users do
    collection do
      resource :registrations, only: [:show, :new, :create]
      resource :sessions, only: [:new, :create, :destroy]
      resource :confirmations, only: [:show]
    end
  end
end
