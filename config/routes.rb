Rails.application.routes.draw do
  get  'admins/price_customers/add_list'    => 'admins/price_customers#add_price_list',    as: :admins_price_customers_add_list
  post 'admins/price_customers/create_list' => 'admins/price_customers#create_price_list', as: :admins_price_customers_create_list

  get '/admins/price_customers/:id/edit_list'     => 'admins/price_customers#edit_price_list', as: :admins_price_customers_edit_list
  patch '/admins/price_customers/:id/update_list' => 'admins/price_customers#update_price_list', as: :admins_price_customers_update_list

  post '/admins/price_customers/:route/:price_customer/update_rate'   => 'admins/price_customers#update_rate', as: :admins_price_customers_update_rate

  devise_for :admins, ActiveAdmin::Devise.config.merge({path: '/admins'})
  ActiveAdmin.routes(self)

  get  'customer/prices'  => 'customer#prices'

  devise_for :customers, :path => '/customer', controllers: { registrations: :registrations , passwords: :passwords, sessions: :sessions, confirmations: :confirmations }

  get "/customer" => "campaigns#index"
  get '/customer/profile' =>  'customer#profile', as: :customer_profile
  post '/customer/profile' =>  'customer#update_profile', as: :customer_update_profile


  resources :campaigns, path: "/customer/campaigns"
  resources :lists, path: "/customer/lists" do
    resources :contacts

    member do
      get 'import'
      post 'import_map'
      post 'upload'
    end

    resources :column_lists
  end

  resources :outgoings, path: "/customer/outgoings", only: [:index, :show]

  # pages
  scope "(:locale)", :locale => /en|es/ do
    root :to => 'pages#home'
    get "pages/home"
    get 'pages/about'
  end
  post 'change_language' =>  'pages#change_language', as: :change_language

end

