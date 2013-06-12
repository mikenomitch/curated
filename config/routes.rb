Curate::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :albums
    resources :songs
  end

  resources :songs
  resources :albums

  # get "albums/index"
  root :to => "pages#index"

  post "users/sign_in"
  post "users/sign_up"
  post "users/edit"

  match "/:username" => "albums#index"
  match "/:username/albums" => "albums#index"
  # match "/:username/albums/:id" => "albums#update", :via => [:get, :post]
  match "/:username/songs" => "songs#index"
  match "/:username/return_user" => "albums#get_user"
  match "/:username/albums/return_user" => "albums#get_user"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
