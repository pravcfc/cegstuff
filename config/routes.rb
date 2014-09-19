Cegstuff::Application.routes.draw do
  get "users/new"
 # get '/' => 'posts#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root to: "users#news_feed"
   get 'about' => 'home#about'
   get 'register' => 'users#new'
   get 'signin' => 'sessions#new'
   get 'feed' => 'users#news_feed'
   match 'signout', to: "sessions#destroy", via: :delete

   resources :users do
     member do 
       get :following, :followers
     end
   end

  resources :posts do
    resources :comments
    resources :taggings, only: [:show]
  end

  resources :relations, only: [:create, :destroy]

  resources :sessions, only: [:new, :create, :destroy]
end
