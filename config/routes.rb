Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'tops#index'
  resources :users, only: %i[new create]
  resources :posts do
    resources :comments, only: %i[create], shallow: true
    collection do
      get 'posted'
      get 'likes'
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resources :bookmarks, only: %i[create destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
