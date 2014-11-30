class Currency < ActiveRecord::Base
  self.table_name = 'currency'

  has_many :smss
  has_many :customers
end
