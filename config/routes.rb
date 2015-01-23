Rails.application.routes.draw do

  root 'cards#index'
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :users, shallow: true do 
    resources :trades, shallow: true do
      resources :comments
    end
  end

  post "accept_trade/:id" => "trades#accept", :as => "accept_trade"
  post "cancel_trade/:id" => "trades#cancel", :as => "cancel_trade"


  # https://coderwall.com/p/kqb3xq/rails-4-how-to-partials-ajax-dead-easy
  get "/fetch_list" => 'users#from_list', as: 'fetch_list'
  get "/fetch_inventory/:id" => 'users#from_inventory', as: 'fetch_inventory'
  get "/fetch_trades/:user_id" => 'trades#show_trades_with_status', as: 'fetch_trades'
  
  
  post "/return_first_search_result" => 'cards#return_first_search_result', as: 'return_first_search_result'
  post "/find_users_by/:card_id" => 'users#find_users_by', as: 'find_users_by'

  resources :sessions
  resources :cards, only: [:index, :show]
  resources :password_resets



  post "users/whereami" 

  post '/users/:id/update_lists' => 'users#update_lists', as: :update_lists

  put 'add_to_tradeable/:card_id' => 'users#add_to_tradeable', as: :add_to_tradeable
  put 'add_to_wanted/:card_id' => 'users#add_to_wanted', as: :add_to_wanted
  put "add_to_inventory/:card_id" => 'users#add_to_inventory', as: :add_to_inventory

  get 'update_nav_bar_unaccepted_trades_count' => 'users#update_nav_bar_unaccepted_trades_count'

  # put 'remove_from_tradeable/:card_id' => 'users#remove_from_tradeable', as: :remove_from_tradeable
  # put 'remove_from_wanted/:card_id' => 'users#remove_from_wanted', as: :remove_from_wanted
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
