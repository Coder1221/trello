Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

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
end
