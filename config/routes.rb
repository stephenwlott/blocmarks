Rails.application.routes.draw do

  #get 'topics/create'
  #get 'topics/destroy'
  #get 'topics/index'
  #get 'topics/show'
  #get 'topics/new'
  #get 'topics/edit'

  devise_for :users
  resources :users, only: [:show] do
    resources :topics
  end
  
  post :incoming, to: 'incoming#create'
  
  get 'welcome/index'
  get 'welcome/about'
  
  #root to: 'topics#index'
  root to: 'welcome#index'

end
