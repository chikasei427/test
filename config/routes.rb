Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  get 'signup', to: 'photographers#new'
  resources :photographers, only: [:index, :show, :new, :create] do
    member do
      get :favorittings
    end
  end
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :favorites, only: [:create, :destroy]
  
  resources :posts
  
end
