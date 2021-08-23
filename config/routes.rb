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


# b49f107f8560cce6cc40607f0e09d202f6b6048a86364b5a8d11bd315180aee7