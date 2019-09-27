Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :groups

  devise_scope :user do
    authenticated  do
      root to: 'users#dashboard_view'
      get '/users/sign_out' => 'devise/sessions#destroy'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
