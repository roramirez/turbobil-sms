ActiveAdmin.register Route do

  scope_to :current_admin

  permit_params :prefix, :name, :price_list, :telco_id

  filter :name
  filter :prefix

  form do |f|
    f.inputs "Details" do
      f.input :prefix,        :as => :string
      f.input :name,          :as => :string
      f.input :price_list
      f.input :telco_id
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :prefix
      row :name
      row :price_list
      row :telco_id
    end
  end

  index do
    column :prefix
    column :name
    column :price_list
    column :telco_id
    actions
  end

end
