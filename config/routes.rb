Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'users#destroy', as: 'signout'


  resources :users, only: [:create, :destroy]
  resource :homepages, only: [:index] do
    collection do
      get :callback
      get :redirect
    end
  end

  root to: "homepages#index"
end
