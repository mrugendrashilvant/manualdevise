Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login', to: 'accounts#login'
  get '/signup', to: 'accounts#signup'

  get '/forgot-password', to: 'passwords#forgot'
  get '/reset-password', to: 'passwords#reset'
end
