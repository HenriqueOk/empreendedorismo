Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'championships#search'

  resources :championships, only: [:create] do
    collection do
      post :find
    end
  end

end
