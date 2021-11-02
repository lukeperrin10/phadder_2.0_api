# frozen_string_literal: true

Rails.application.routes.draw do

  # Devise routes for callbacks. Can't be in locale scope
  # devise_for :users, only: :omniauth_callbacks,
  #                    controllers: { omniauth_callbacks: :omniauth_callbacks }

  # scope '(:locale)', locale: /en|sv|ar|pl|bs|fa|ru|sr/ do
  #   devise_for :users, path: '', skip: :omniauth_callbacks, controllers: {
  #     sessions: :sessions,
  #     registrations: :registrations,
  #     omniauth_callbacks: :omniauth_callbacks
  #   }, path_names: { sign_up: 'account', sign_out: 'leave' }

  #   resources :service_providers, except: [:destroy] do
  #     collection do
  #       post :search, action: :index, as: :search
  #     end
  #   end

  #   resources :users, only: %i[index show update edit destroy]
  #   get :pre_register, controller: :users, action: :pre_register
  #   resources :service_requests, only: %i[create index show] do
  #     resources :bids, only: %i[new create update]
  #   end

  #   # Static pages
  #   get '/pages/:id', controller: 'high_voltage/pages', action: :show, as: :page, format: false
  #   root controller: :application, action: :index
  # end

  # API routes
  namespace :api, defaults: { format: :json } do
    # mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    #   omniauth_callbacks: 'api/omniauth_callbacks',
    #   sessions: 'api/sessions', 
    #   registrations: 'api/registrations'
    # }

    resources :service_requests, only: %i[index show create]
    resources :bids, only: [:create], path: 'service_requests/bids'
    resources :tracked_service_requests, only: %i[create index]
    resources :users, only: [:show]
    resources :language_queries, only: [:create]
    resources :post_code_queries, only: [:create]
    resources :categories, only: [:index]
  end

  # handle 404's but make sure ActiveStorage is still working

  # get '*unmatched_route', controller: :application, action: :raise_not_found, constraints: lambda { |req|
  #   req.path.exclude? 'rails/active_storage'
  # }
end
