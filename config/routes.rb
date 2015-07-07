Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show]
  
  post :incoming, to: 'incoming#create'
  
  get 'welcome/index'
  get 'welcome/about'
  
  root to: 'welcome#index'

end
