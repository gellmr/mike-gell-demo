Fuzzybear::Application.routes.draw do

  root   'home#index'

  get    "/home/index"             => 'home#index',             as: 'home_index'
  get    '/home'                   => 'home#index',             as: 'home'

  get    '/register'               => 'sessions#register_page', as: 'register'
  post   '/sessions'               => 'sessions#create',        as: 'sessions_path'
  get    '/session-expired-notice' => 'sessions#expired_notice'

  get    '/login/'                 => 'sessions#login_page',    as: 'login'
  delete '/logout/'                => 'sessions#destroy',       as: 'logout'

  get    '/forgot-password'        => 'password_reset#new',              as: 'new_password_reset' # Serve form to request pw change token
  post   '/forgot-password'        => 'password_reset#create',           as: 'create_password_reset' # Submitted a form to request new token
  get    '/set-new-password'       => 'password_reset#set_new_password', as: 'set_new_password' # Serve form to change password
  post   '/change_password'        => 'password_reset#change_password',  as: 'change_password' # Submit new password and confirmation

  get    '/store/'                 => 'store#index',                     as: 'store_index'
  get    '/store/search'           => 'store#product_search',            as: 'store_search'

  #resources :cart, only: [:update]
  get    '/cart/'                  => 'cart#index',                      as: 'cart_index'
  get    '/cart/is-empty'          => 'cart#is_empty',                   as: 'cart_is_empty'
  put    '/cart/'                  => 'cart#update',                     as: 'cart_update'
  delete '/cart/'                  => 'cart#destroy',                    as: 'clear_cart'

  get  '/checkout/'                => 'checkout#index'
  post '/checkout/submit'          => 'orders#create'




  # CUSTOMER ROUTES

  # create an account                         create
  # get my account details                    read
  # update my account details                 update
  # delete my account                         delete
  post   '/user-customer'                    => 'user_customer#create',  as: 'create_my_account'
  get    '/user-customer/:id(.:format)/edit' => 'user_customer#edit',    as: 'edit_my_account'
  patch  '/user-customer/:id(.:format)'      => 'user_customer#update',  as: 'update_my_account'
  delete '/user-customer/:id'                => 'user_customer#destroy', as: 'delete_my_account'

  # create an address                         create
  # get my addresses                          read
  # update my addresses                       update
  # delete an address                         delete
  post   '/user-customer-address'               => 'user_customer_address#create',  as: 'create_address'
  get    '/user-customer-address/:id(.:format)' => 'user_customer_address#edit',    as: 'edit_my_addresses'
  patch  '/user-customer-address/:id(.:format)' => 'user_customer_address#update',  as: 'update_my_address'
  delete '/user-customer-address/:id'           => 'user_customer_address#destroy', as: 'delete_address'

  # get a list of my orders
  # show the details of an order
  get  '/customer/:id/orders'                   => 'orders#index',    as: 'customer_orders'
  get  '/customer/:id/order/:id'                => 'orders#show',     as: 'customer_order'





  # STAFF ONLY

  # get a list of existing customers          read
  # get    a customer's account details page  read
  # update a customer's account details       update
  # delete a customer account                 delete
  get    '/staff-edit-customer'               => 'staff_edit_customer#index',   as: 'staff_edit_customers'
  get    '/staff-edit-customer/:id(.:format)' => 'staff_edit_customer#edit',    as: 'staff_edit_customer'
  patch  '/staff-edit-customer/:id(.:format)' => 'staff_edit_customer#update',  as: 'staff_update_customer'
  delete '/staff-edit-customer/:id'           => 'staff_edit_customer#destroy', as: 'staff_delete_customer'

  # create a customer's address               create
  # get      customer's addresses             read
  # update a customer's address               update
  # delete a customer's address               delete
  post   '/staff-edit-customer-address'               => 'staff_edit_customer_address#create',  as: 'staff_create_customer_address'
  get    '/staff-edit-customer-address/:id(.:format)' => 'staff_edit_customer_address#edit',    as: 'staff_edit_customer_addresses'
  patch  '/staff-edit-customer-address/:id(.:format)' => 'staff_edit_customer_address#update',  as: 'staff_update_customer_address'
  delete '/staff-edit-customer-address/:id'           => 'staff_edit_customer_address#destroy', as: 'staff_delete_customer_address'




  # ADMIN ONLY

  # create an admin account                   create
  # get a list of existing admin              read
  # get    account details for an admin       read
  # update account details for an admin       update
  # delete an admin account                   delete
  # post   '/admin-edit-admin'                => 'admin_edit_admin#create',  as: 'create_admin'
  # get    '/admin-edit-admin'                => 'admin_edit_admin#index',   as: 'admin'
  # get    '/admin-edit-admin/:id(.:format)'  => 'admin_edit_admin#edit',    as: 'edit_admin'
  # patch  '/admin-edit-admin/:id(.:format)'  => 'admin_edit_admin#update',  as: 'update_admin'
  # delete '/admin-edit-admin/:id(.:format)'  => 'admin_edit_admin#destroy', ad: 'delete_admin'

  # create a staff account                    create
  # get a list of existing staff              read
  # get    account details for a staff        read
  # update account details for a staff        update
  # delete a staff account                    delete
  post   '/admin-edit-staff'               => 'admin_edit_staff#create',  as: 'create_staff'
  get    '/admin-edit-staff'               => 'admin_edit_staff#index',   as: 'staff_index'
  get    '/admin-edit-staff/:id(.:format)' => 'admin_edit_staff#edit',    as: 'edit_staff'
  patch  '/admin-edit-staff/:id(.:format)' => 'admin_edit_staff#update',  as: 'update_staff'
  delete '/admin-edit-staff/:id'           => 'admin_edit_staff#destroy', as: 'delete_staff'




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
