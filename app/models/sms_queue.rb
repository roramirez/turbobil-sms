class SmsQueue < ActiveRecord::Base
  self.table_name = 'sms_queue'

  belongs_to :contact
  belongs_to :campaign
end
