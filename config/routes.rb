Rails.application.routes.draw do
  get 'sessions/new'

  

  get '/' => redirect('/admin')
  # root :to => redirect('/admin')
  get    'user/login'   => 'sessions#new'
  post   'user/login'   => 'sessions#create'
  delete 'user/logout'  => 'sessions#destroy'
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  scope '/admin' do
    root :to => 'home#index'
    resources :menus, :except => [:show,:index]

    resources :users, :except => [:show,:index]
    scope :users do 
      get 'index' => 'users#index', as: :users_index
      get 'profile' => 'home#profile'
      put 'profile' => 'home#profile'
      get 'profile_password' => 'home#profile_password'
      put 'profile_password' => 'home#profile_password'
      get 'password'
      get 'view/:id' => 'users#show', as: :users_view
    end

    scope :menus do
      get 'index' => 'menus#index', as: :menus_index
      get 'view/:id' => 'menus#show', as: :menus_view
      get 'parent/:id'   => 'menus#menu_by', as: :menus_parent 
    end
  end
  # namespace :admin do

  # end
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
