Rails.application.routes.draw do
  
  resources :delivery_addresses do 
    member do
      get :near_by
      get :near_by_products
    end
  end
  namespace :api do 
    namespace :v1 do
      resources :sme_users do 
        collection do 
          post :login
          get :logout
        end
      end
    end
  end
  resources :vendor_addresses
  resources :configs
  resources :draft_orders
  devise_for :admins
  resources :products do 
    member do
      get :commission
    end
  end
  resources :vendor_orders do
    resources :vendor_fulfillments
  end
  resources :vendor_products do 
    resources :vendor_variants
  end
  devise_for :vendors
  resources :discounts
  resources :orders
  devise_for :sme_users
  root :to => 'home#index'
  get 'profile', to: 'home#profile'
  get 'sme', to: 'home#sme'
  get 'edit_sme', to: 'home#edit_sme'
  patch 'update_sme', to: 'home#update_sme'

  get 'vendor', to: 'home#vendor'
  get 'edit_vendor', to: 'home#edit_vendor'
  patch 'update_vendor', to: 'home#update_vendor'
  get 'sme/products', to: 'home#sme_products'
  get 'varify_sme_user', to: 'home#varify_sme_user'
  get 'download_invoice', to: 'home#download_invoice'
  get 'invoice', to: 'home#invoice'

  resource :marketing_activities, only: [:create, :update] do
    patch :resume
    patch :pause
    patch :delete
    post :republish
    post :preload_form_data
    post :preview
    post :errors
  end
  post '/webhooks/order_create', :to => 'webhooks#order_create'
  mount ShopifyApp::Engine, at: '/'
# frozen_string_literal: true

namespace :app_proxy do
  root action: 'index'
  # simple routes without a specified controller will go to AppProxyController

  # more complex routes will go to controllers in the AppProxy namespace
  #   resources :reviews
  # GET /app_proxy/reviews will now be routed to
  # AppProxy::ReviewsController#index, for example
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
