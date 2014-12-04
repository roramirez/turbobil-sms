class Campaign < ActiveRecord::Base
  self.table_name = 'campaign'


  belongs_to :list
  belongs_to :customer

  def status_text

    if status == 1
      if Time.now < init
        'active'
      else
        'waiting'
      end
    else
      'stopped'
    end
  end
end
