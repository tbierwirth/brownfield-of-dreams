Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create, :edit, :update, :destroy]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/auth/github', as: 'github_auth'
  get '/auth/github/callback', to: 'github/sessions#create'

  get '/invite', to: 'invite#new', as: 'invite'
  post '/invite', to: 'invite#create', as: 'send_invite'

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/activate', to: 'activation#update', as: 'activation'
  get '/activated', to: 'activation#show', as: 'activated'

  resources :users, only: [:new, :create]

  resources :tutorials, only: [:show] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create]

  resources :friendships, only:[:create]
end
