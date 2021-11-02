# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :service_requests, only: %i[index show create]
    resources :bids, only: [:create], path: 'service_requests/bids'
    resources :tracked_service_requests, only: %i[create index]
    resources :users, only: [:show]
    resources :language_queries, only: [:create]
    resources :post_code_queries, only: [:create]
    resources :categories, only: [:index]
  end
end
