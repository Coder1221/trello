Rails.application.routes.draw do
  root to: "home#index"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # devise_for :users, :controllers => {
  #   :registrations => "users/registrations",
  #   :sessions => "users/sessions",
  #   :passwords => "users/passwords",
  #   :confirmations => "users/confirmations"
  # }
  
  #   confirmations: 'users/confirmations',
  #   passwords: 'users/passwords'

  # devise_for :users
  #resourse full routes 
  resources :home do
    member do
      get :delete
    end
  end

  resources :boards do
    member do
      get :delete
    end
  end

  resources :tasks do
    member do
      get :delete
    end
  end

end
