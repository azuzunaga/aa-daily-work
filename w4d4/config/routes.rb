Rails.application.routes.draw do
  resource :session, only: [:create, :new]
  resource :session, only: :destroy

  resources :users, only: [:create, :new, :show]

  resources :bands 
end
