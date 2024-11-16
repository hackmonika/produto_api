Rails.application.routes.draw do
  # User management endpoints
  resources :users, only: [ :create, :show, :update, :destroy ]  # No :index

  # Product management endpoints
  resources :products, only: [ :index, :show, :create, :update, :destroy ]

  # Session management for authentication
  post   "sign_in",  to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"
end
