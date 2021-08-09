Rails.application.routes.draw do
  root to: "home#index"
 
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
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

  resources :tasks do
    member do
      get :delete
    end
  end
 
  resources :subtasks do
    member do
      get :delete
    end
  end
end
