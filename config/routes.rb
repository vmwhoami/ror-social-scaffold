Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  post 'add', to: 'friendships#add'
  put 'accept', to: 'friendships#accept'
  delete 'destroy', to: 'friendships#destroy'
end
