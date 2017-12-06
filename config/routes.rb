Rails.application.routes.draw do

  get 'ranking' => 'ranking#index'
  post 'championships/:id/atualizar_partidas' => 'championships#atualizar_partidas', as: "atualizar_partidas"
  post 'championships/:id/finish' => 'championships#finalizar_campeonato', as: "championship_finish"

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "callbacks", 
    :registrations => 'registrations',
    :sessions => 'sessions'     
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#index'

  resources :championships

  resources :interests, only: [:index, :new, :create] do
    get :search, on: :collection
    put :participate, on: :member
  end

  resources :brackets, only: [] do
    member do
      get 'finish' => 'brackets#finish'
    end
  end
end
