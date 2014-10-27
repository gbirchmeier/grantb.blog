GrantbBlog::Application.routes.draw do

  root 'front_page#index'

  get "sign/in", to: "sessions#new", as: "login"
  get "sign/out", to: "sessions#destroy", as: "logout"
  resources :sessions

  get '/no', to: redirect('/no.html'), as: "not_allowed"

  resources :posts, only: [:index,:show]

  resources :tags, only: [:index,:show]

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :posts
    # TODO figure out how to get this route to be named "fob_admin_post"
    #get "posts/:id/fob", to: "posts#fob", as: "fob_post"
  end
  # TODO move this to namespace when above puzzle is solved
  get "admin/posts/:id/delete", to: "admin/posts#delete", as: "delete_admin_post"


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
