Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :chats, only: [:show, :create]
  resources :users, only: [:show, :edit, :index, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end
  resources :books do
    resource:favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
