Rails.application.routes.draw do
  root "courses#index"
  resources :courses
  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions'
  }

  resource :profile, only: [:show]
  resources :courses do
    member do
      post :subscribe
      delete :unsubscribe
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
