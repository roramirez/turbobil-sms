class Contact < ActiveRecord::Base
  self.table_name = 'contact'
  belongs_to :list
end
