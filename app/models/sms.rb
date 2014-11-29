class Sms < ActiveRecord::Base
  self.table_name = 'sms'
  include Filterable

  belongs_to :customer
  belongs_to :provider
  belongs_to :currency
  belongs_to :route
  belongs_to :price_customer
  belongs_to :admin

  scope :ip, ->(ip) {where(ip: ip)}

  scope :today, -> {where(:at => Date.today...Date.tomorrow)}
  scope :sms_end, ->(sms_end)  {where("at <= :end_date",  {end_date: sms_end})}
  scope :sms_start, ->(sms_start) {where("at >= :start_date",  {start_date: sms_start})}

  def duration_hhmmss
    seconds = 0
    if !duration.nil?
      seconds = duration
    end
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

end
