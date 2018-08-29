Rails.application.routes.draw do
  resources :tags, except: :show
  resources :tickets do
    resources :comments
  end
  resources :projects

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  root to: 'projects#index'
end
