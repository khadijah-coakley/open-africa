Rails.application.routes.draw do

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'users/registrations', :omniauth_callbacks => "omniauth_callbacks" }
  get "/users", to: 'users#index'
  get "/users/profile", to: 'users#show', as: :my_profile

end
