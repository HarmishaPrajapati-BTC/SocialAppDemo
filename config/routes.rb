Rails.application.routes.draw do
  devise_for :users, controllers: {
                   sessions: 'users/sessions',
                   registrations: 'users/registrations',
                   omniauth_callbacks: "users/omniauth_callbacks"}
  resources :posts do
    resources :likes
    member do
      delete :delete_image_attachment
    end
    get 'liked_by_user', to: 'posts#liked_by_user'
  end
  get 'your_groups', to: 'groups#your_groups'
  get 'notifications/link_through'
  resources :groups
  resources :comments
  resources :users
  resources :notifications
  devise_scope :user do
    authenticated  do
      root to: 'posts#index'
      get '/users/sign_out' => 'devise/sessions#destroy'
      get 'auth/:provider/callback', to: 'sessions#googleAuth'
      get 'auth/failure', to: redirect('/')
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end

  get 'groups_of_users', to: 'users#groups_of_users'
  get 'find_friends', to: 'users#find_friends'
  get 'friend_list', to: 'users#friend_list'
  get 'create_notifications/:id', to: 'users#create_notifications', as: :'create_notifications'
  get 'account', to: 'users#account'
  get 'join_group/:id', to: 'groups#join_group', as: :'join_group'
  get 'leave_group/:id', to: 'groups#leave_group', as: :'leave_group'
  get 'accept_friend_request/:id', to: 'users#accept_friend_request', as: :accept_friend_request
  get 'remove_from_friends/:id', to: 'users#remove_from_friends', as: :remove_from_friends
  get 'reject_friend_request/:id', to: 'users#reject_friend_request', as: :reject_friend_request
  get 'post_comments/:id', to: 'comments#post_comments', as: :post_comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
