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
end
