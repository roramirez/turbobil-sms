class AddLanguageToCustomer < ActiveRecord::Migration
  def change
    add_column :customer, :language, :string
  end
end
