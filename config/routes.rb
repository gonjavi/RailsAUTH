Rails.application.routes.draw do
  resources :users
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/post',   to: 'posts#new'
  post   '/post',   to: 'posts#create'
  get '/showPosts',  to: 'posts#index'
  root 'sessions#new'
  resources :posts 
end
