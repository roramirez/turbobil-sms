class Campaign < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  self.table_name = 'campaign'

  belongs_to :list
  belongs_to :customer
  has_many :sms_queues

  def status_text
    if status == 1
      if Time.now > init
        'active'
      else
        from_time = (init - Time.now).ago
        'waiting ' + time_ago_in_words(from_time)
      end
    else
      'stopped'
    end
  end

  def self.actives
    where(status: 1).
    where("init < ?", DateTime.now)
  end

  def get_sms_pending
    sms_send = sms_queues
    contact_send_ids = []
    sms_send.each do |send|
      contact_send_ids.append(send.contact_id)
    end
    list.contact.where.not(id: contact_send_ids)
  end

end
