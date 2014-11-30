class Currency < ActiveRecord::Base
  self.table_name = 'currency'

  has_many :outgoings
  has_many :customers
end
