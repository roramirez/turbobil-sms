class TmpContactList < ActiveRecord::Base
  self.table_name = 'tmp_contact_list'
  belongs_to :list
end
