ActiveAdmin.register Customer, namespace: :admins do

  scope_to :current_admin

  permit_params :name, :email, :type_customer, :credit, :type_pay, :password, :price_customer_id, :active

  filter :type_customer
  filter :price_customer, :collection => proc {PriceCustomer.where admin: current_admin }

  sidebar "Details", only: [:show, :edit] do
    ul do
      #add link to sidebar
    end
  end

  controller do
    def update
      if params[:customer][:password].blank?
        params[:customer].delete("password")
        params[:customer].delete("password_confirmation")
      end
      super
    end
  end


  form do |f|
    f.inputs "Details" do
      f.input :name,          :as => :string
      f.input :email,         :as => :email
      f.input :active,        :as => :boolean
      f.input :type_customer
      f.input :credit
      f.input :password
      f.input :type_pay,      :as => :select,  :collection => { 'Prepay' => 1, 'Postpay' => 2 }
      f.input :price_customer, :collection => PriceCustomer.where(admin: current_admin)
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :email
      row :type_customer
      row :credit
      row (:active) do |customer|
        customer.active? ? status_tag('yes', :ok) : status_tag('no')
      end
      row("Type Payment") { |customer| status_tag (customer.type_pay_label)  }
    end
  end

  index do
    column :id
    column :name
    column :email
    column :credit
    column :active
    column("Type Payment") { |customer| status_tag (customer.type_pay_label)  }
    actions
  end

end
