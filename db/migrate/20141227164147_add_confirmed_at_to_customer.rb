class AddConfirmedAtToCustomer < ActiveRecord::Migration
  def change
    add_column :customer, :confirmed_at, :timestamp
    add_column :customer, :confirmation_sent_at, :timestamp
    add_column :customer, :confirmation_token, :text
    add_column :customer, :unconfirmed_email, :string
  end
end
