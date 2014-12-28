ActiveAdmin.register Provider do

  scope_to :current_admin

  permit_params :name, :email, :balance,  :host, :username, :password

  filter :type_customer

  sidebar "Details", only: [:show, :edit] do
    ul do
      li link_to("Routes", admins_provider_rates_path(provider))
    end
  end



  form do |f|
    f.inputs "Details" do
      f.input :name,          :as => :string
      f.input :email,         :as => :email
      f.input :balance
    end
    f.inputs "Connection" do
      f.input :protocol
      f.input :host,         :as => :string
      f.input :username,     :as => :string
      f.input :password,     :as => :password
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :email
      row :balance


    end
    panel "Connection" do
      attributes_table_for provider do
        row :protocol
        row :host
        row :username
        row :password
      end
    end

  end

  index do
    column :id
    column :name
    column :email
    column :balance
    actions
  end

end
