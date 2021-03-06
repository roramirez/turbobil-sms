ActiveAdmin.setup do |config|

  config.site_title = "BoxTub"

  config.allow_comments = false
  config.batch_actions = false

  config.default_namespace = :admins

  config.namespace :admins do |admin|
    admin.authentication_method = :authenticate_admin!
    admin.current_user_method = :current_admin
    admin.logout_link_path = :destroy_admin_session_path
    admin.root_to = 'outgoings#index'
  end

  config.namespace :customers do |customer|
    customer.authentication_method = :authenticate_customer!
    customer.current_user_method = :current_customer
    customer.logout_link_path = :destroy_customer_session_path
    customer.root_to = 'outgoings#index'
  end


end
