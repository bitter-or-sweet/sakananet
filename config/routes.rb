Rails.application.routes.draw do
  root 'tops#index'
  resorces :users, only: %i[new create]
end
