class Campaign < ActiveRecord::Base
  self.table_name = 'campaign'


  belongs_to :list
  belongs_to :customer

end
