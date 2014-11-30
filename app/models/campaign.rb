class Campaign < ActiveRecord::Base
  self.table_name = 'campaign'

  has_many :sms_queues

  belongs_to :list
  belongs_to :customer

end
