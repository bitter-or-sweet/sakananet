Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'tops#index'
  resources :users, only: %i[new create show] do
    resources :posts, only: [:index], on: :member
  end
  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get 'posted'
      get 'likes'
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resources :likes, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
  resources :appetizers, only: %i[new create show]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'terms_of_use', to: 'tops#terms_of_use'
  get 'privacy_policy', to: 'tops#privacy_policy'
end
