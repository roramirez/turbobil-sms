class List < ActiveRecord::Base
  self.table_name = 'list'


  has_many :campaigns
  belongs_to :customer

  def to_s
    :name
  end
end
