Fuzzybear::Application.routes.draw do

  resources :users, only: [:create, :update, :edit] do
    # POST  /users             users#create    users_path
    # PATCH /users/:id         users#update    user_path
    # GET   /users/:id/edit    users#edit      edit_user_path
    resources :orders, only: [:index, :show, :create]
      # GET  /users/:id/orders/     orders#index  user_orders_path
      # GET  /users/:id/orders/:id  orders#show   user_order_path
  end

  get "home/index" => 'home#index'   # home_index_path
  get 'home/'      => 'home#index'   # home_path

  resources :sessions, only: [:create]
    # POST  /sessions  sessions#create   sessions_path

  get 'session-expired-notice/' => 'sessions#expired_notice'
  delete 'logout/' => 'sessions#destroy'
  get 'login/'     => 'sessions#login_page', as: 'login'
  get 'register/'  => 'sessions#register_page', as: 'register'

  get 'store/'     => 'store#index', as: 'store_index'
  put 'store/'     => 'store#product_search'

  resources :cart, only: [:update]
  get 'cart/'      => 'cart#index', as: 'cart_index'
  get 'cart/is-empty' => 'cart#is_empty', as: 'cart_is_empty'
  put 'cart/'      => 'cart#update'
  delete 'cart/'     => 'cart#destroy', as: 'clear_cart'
  post 'cart/submit' => 'orders#create' # cart_submit_path

  root 'home#index'

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
