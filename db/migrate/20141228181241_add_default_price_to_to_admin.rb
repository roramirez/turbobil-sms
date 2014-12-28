class AddDefaultPriceToToAdmin < ActiveRecord::Migration
  def change
    add_reference :admin, :default_price_customer, references: :price_customer
  end
end
