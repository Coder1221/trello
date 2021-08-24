Rails.application.routes.draw do
  root to: "boards#index"
  # get 'reminders/index'
  resources :reminders
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }
  
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

  resources :lists do
    member do
      get :delete
    end
  end
  
  resources :todos do
    member do
      get :delete
    end
  end

end