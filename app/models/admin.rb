class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :rememberable, :trackable, :validatable
  self.table_name = 'admin'

  has_many :outgoings
  has_many :price_customers
  has_many :routes
  has_many :providers
  has_many :customers

  belongs_to :default_price_customer, class_name: "PriceCustomer"

end
