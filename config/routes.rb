Rails.application.routes.draw do
  constraints subdomain: /(admin|corporation)/ do
    constraints subdomain: /^admin/ do

      root to: "admin/top_pages#show", as: :admin_root

      defaults subdomain: "admin" do
        scope module: :admin, as: :admin do
          scope constraints: lambda { |r| r.env['warden'].user(:admin).nil?} do
            get "login", to: "sessions#new", as: "login"
          end
          resource :sessions, only: [:create, :destroy]
          resource :confirmations, only: [:show]
        end
      end
    end

    constraints subdomain: /^corporation/ do
      root to: "corporation/top_pages#show", as: :corporation_root
      defaults subdomain: "corporation" do
        scope module: :corporation, as: :corporation do
          scope constraints: lambda { |r| r.env['warden'].user(:corporation).nil?} do
            get "login", to: "sessions#new", as: "login"
          end
          resource :sessions, only: [:create, :destroy]
          resource :confirmations, only: [:show]
        end
      end
    end
  end

  resources :users do
    collection do
      resource :registrations, only: [:show, :new, :create]
      resource :sessions, only: [:new, :create, :destroy]
      resource :confirmations, only: [:show]
    end
  end

  namespace :v1, defaults: {format: :json} do
    post "welcome", to: "welcome#index"
  end
end
