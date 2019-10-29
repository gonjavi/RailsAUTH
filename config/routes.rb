Rails.application.routes.draw do
  get 'authentications/home'
  resources :users
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/signup',      to: 'users#new', as: 'signup'
  root 'authentications#home'
  resources :posts 
end
