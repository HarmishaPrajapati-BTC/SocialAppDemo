Rails.application.routes.draw do
  devise_for :users, controllers: {
                   sessions: 'users/sessions',
                   registrations: 'users/registrations',
                   omniauth_callbacks: "users/omniauth_callbacks"}
  resources :posts do
    member do
      delete :delete_image_attachment
    end
  end
  resources :groups
  resources :users

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
  get 'account', to: 'users#account'
  get 'join_group/:id', to: 'groups#join_group', as: :'join_group'
  get 'leave_group/:id', to: 'groups#leave_group', as: :'leave_group'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
