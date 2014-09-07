Cegstuff::Application.routes.draw do
  get "users/new"
 # get '/' => 'posts#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root to: "posts#index"
   get '/about' => 'home#about'
   get '/register' => 'users#new'
   get '/signin' => 'sessions#new'
   get '/feed' => 'users#news_feed'
   post '/signout', to: 'sessions#destroy'

   resources :users do

   end

  resources :posts do
    resources :comments
  end

  resources :sessions, only: [:new, :create, :destroy]
end
