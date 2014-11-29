class Campaign < ActiveRecord::Base
  self.table_name = 'campaign'


  belongs_to :list
  belongs_to :customer

  def self.actives
    where(status: 1).
    where("init < ?", DateTime.now)
  end
end
