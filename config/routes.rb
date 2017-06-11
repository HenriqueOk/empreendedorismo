Rails.application.routes.draw do

  get 'ranking/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#index'

  resources :championships
end
