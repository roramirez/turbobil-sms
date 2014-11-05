class Provider < ActiveRecord::Base
  self.table_name = 'provider'

  validates_presence_of :name

  has_many :calls
  has_many :rates

  belongs_to :admin
  belongs_to :protocol
end
