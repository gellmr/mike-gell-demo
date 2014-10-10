Fuzzybear::Application.routes.draw do

  resources :users, only: [:create, :update, :edit] do
    # POST  /users             users#create    users_path
    # PATCH /users/:id         users#update    user_path
    # GET   /users/:id/edit    users#edit      edit_user_path

    resources :orders, only: [:index, :show, :create]
      # GET  /users/:id/orders/     orders#index  user_orders_path
      # GET  /users/:id/orders/:id  orders#show   user_order_path

    get    '/addresses'           => 'user_addresses#edit',  as: 'addresses'
    post   '/address(.:format)'   => 'user_addresses#create',  as: 'create_address'
    delete '/address/:id(.:format)' => 'user_addresses#destroy', as: 'delete_address'
  end

  get "home/index" => 'home#index'   # home_index_path
  get 'home/'      => 'home#index'   # home_path

  resources :sessions, only: [:create]
    # POST  /sessions  sessions#create   sessions_path

  get  '/forgot-password' => 'password_reset#new',    as: 'new_password_reset' # Serve form to request pw change token
  post '/forgot-password' => 'password_reset#create', as: 'create_password_reset' # Submitted a form to request new token
  
  get  '/set-new-password' => 'password_reset#set_new_password', as: 'set_new_password' # Serve form to change password
  post '/change_password' => 'password_reset#change_password', as: 'change_password' # Submit new password and confirmation

  get 'session-expired-notice/' => 'sessions#expired_notice'
  delete 'logout/' => 'sessions#destroy'
  get 'login/'     => 'sessions#login_page'
  get 'register/'  => 'sessions#register_page'

  get 'store/'       => 'store#index', as: 'store_index'
  get 'store/search' => 'store#product_search', as: 'store_search'

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
