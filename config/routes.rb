Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { 
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
    post "/unique_email", to: "users/registrations#unique_email?"
  end
  
  resources :orders
  resource :carts do
    get :checkout
    collection do
      post :pay
      get :confirm
    end
  end
  # , only: [:show, :destroy] do
  #   post ':add_item/:id',aciton: 'add_item' 

  resources :rooms
  resources :messages
  resource :driver_profiles, path: '/drivers', only: [:new, :create, :edit, :update] do
    get :index
  end

  resources :stores, only: [] do
    member do
      get :delicacy
    end
  end

  resource :stores do
    collection do
      get :recommand
      get :index
      get :search
    end
    resource :orders, only: [:new] do
      get :preparing
      get :delivering
      get :record
    end
    resources :products, shallow: true, only: [:show, :new, :create, :edit, :update, :destroy] do
      collection do
        get :index
      end
      member do
        patch :toggle_publish
      end
    end
  end
end
