GoodDog::Application.routes.draw do
  get "home/index"

  devise_for :users, :controllers => { :sessions => "admins/sessions",:registrations => "admins/registrations"}
  as :user do
    get 'getstarted' => 'home#get_started', :as => :new_user_session

  end

  root :to => "home#index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  resources :dogs
  
  #resources :payment_notification
  
  match "/search-near" => 'home#search_churches_near_user', :as => :non_profit_near
  
  match "/search" => "non_profits#search_by_name", :as => :search_by_name
  
  match '/payment_notification' => 'payment_notification#create', :as => :payment_notification
  
  match '/send_mail_messages' => 'admin/mail_messages#send_messages', :as => :send_messages
  match '/compose_email' => 'admin/mail_messages#compose_email', :as => :compose_email
            
  
  match '/nonprofit/:id' => 'non_profits#show', :as => :nonprofit_view
  match '/nonprofit/:id/:dog_id' => 'non_profits#show', :as => :nonprofit_with_dog_view
  match '/new_nonprofit' => 'non_profits#new', :as => :new_nonprofit
   
  match '/add_gift_code/:non_profit_id/:gift_code' => 'reservations#validate_gift_code', :as=> :add_gift_code
  match '/validate_gift_codes/:non_profit_id' => 'reservations#validate_gift_code_list', :as=> :add_gift_code_list
  match '/nonprofitselect' => 'non_profits#select', :as => :nonprofit_select
  match '/nonprofit_readonly/:id' => 'non_profits#blocks_readonly', :as => :blocks_readonly

  match '/validate_block_option/:option_id/:non_profit_id/:gift_code' => 'reservations#validate_block_option', :as => :validate_block_option
  
  match '/viewdog/:id', :to => 'blocks#view_dog', :as => 'viewdog'
  match '/previewdog/:id', :to => 'blocks#preview_dog', :as => 'previewdog'

  match '/getstarted', :to => 'home#get_started', :as => 'getstarted'
  match '/legal_mumbo', :to => 'home#legal_mumbo', :as => 'legal_mumbo'
  match 'get_us', :to => 'home#get_us', :as => 'get_us'
  match 'spread_the_word', :to => 'home#spread_the_word', :as => 'spread_the_word'
  match 'all_sponsors', :to => 'home#all_sponsors', :as => 'all_sponsors'
  match 'overview', :to => 'home#overview', :as => 'overview'
  match 'promotions', :to => 'home#promotions', :as => 'promotions'
  match 'info_sponsors', :to => 'home#info_sponsors', :as => 'info_sponsors'
  match 'find_my_block', :to => 'home#find_my_block', :as => 'find_my_block'
  
  match '/save_snapshot/:non_profit_id', :to => 'non_profits#save_snapshot', :as => :save_snapshot
  
  
  match '/reserve/:non_profit_id/:x/:y', :to => 'reservations#new', :as => :reserve
  match '/reserve/:non_profit_id/:x/:y/:reserve_id', :to => 'reservations#new', :as => :reserve_up
  match '/reservation/:reservation_id/save_ap/:associate_producer_id', :to => 'reservations#save_ap', :as => :save_ap
  match '/reservation/:reservation_id/delete_reservation', :to => 'reservations#delete_reservation', :as => :delete_reservation
  
  match '/remove_room/:id', :to => 'rooms#remove', :as => :remove_room
  
  match '/confirm/add_entity', :to => 'reservations#add_entity', :as => :add_entity
  match '/confirm/new_reserve/:room_option_id', :to => 'reservations#new_reserve', :as => :new_reserve
  match '/confirm/update_reserve/:room_option_id', :to => 'reservations#update_reserve', :as => :update_reserve
 
  match '/reserve/add_dog', :to => 'reservations#add_dog', :as => :add_dog 
  match '/reserve/review', :to => 'reservations#review', :as => :review
  
  match '/reservation/add_to_cart', :to => 'reservations#add_to_cart', :as => :add_to_cart
  match '/reservation/checkout/', :to => 'reservations#checkout', :as => :checkout
   
  match '/confirm_purchase', :to => 'reservations#confirm_purchase', :as => :confirm_purchase
  match '/confirmation_room', :to => 'reservations#confirmation_room', :as => :confirm_room 
  
  match '/reserve/confirm/:non_profit_id/:x/:y/:width/:height', :to => 'reservations#create', :as => :confirm_reserve

  match '/room/:reservation_id/create', :to => 'rooms#create', :as => :create_room  
  match '/room/:reservation_id/new', :to => 'rooms#new', :as => :new_room
  
  match '/home/getstarted_form', :to => 'home#getstarted_form', :as => :getstarted_form

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
