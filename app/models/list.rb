class List < ActiveRecord::Base
  self.table_name = 'list'
  belongs_to :customer
end
