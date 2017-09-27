Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'championships#search'

  resources :championships, only: [:create, :show] do
    collection do
      post :find
    end
    member do
      put :finish_creation
    end

    resources :players, only: [:create, :destroy] do
      collection do
        post :create_many
      end
    end

  end
  resources :brackets, only: [] do
    member do
      put :finish
    end
  end

end
