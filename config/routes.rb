require 'sidekiq/web'
Rails.application.routes.draw do
  root to: "boards#index"
  resources :reminders


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }
  #------------------------------------------------------- 
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  get '/sidekiq' => redirect('/')
  #------------------------------------------------------- 


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