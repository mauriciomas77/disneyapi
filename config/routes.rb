Rails.application.routes.draw do
  get 'private/test'
  get '/current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :characters, only: [:index, :create, :destroy, :update, :show]
  resources :movies, only: [:index, :show]
end
