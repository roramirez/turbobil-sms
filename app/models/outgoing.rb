class Outgoing < ActiveRecord::Base
  self.table_name = 'outgoing'
  include Filterable

  belongs_to :customer
  belongs_to :provider
  belongs_to :currency
  belongs_to :route
  belongs_to :price_customer
  belongs_to :admin
  belongs_to :contact
  belongs_to :list
  belongs_to :campaign

  scope :ip, ->(ip) {where(ip: ip)}
  scope :campaign, ->(campaign) {where(campaign_id: campaign)}

  scope :today, -> {where(:at => Date.today...Date.tomorrow)}
  scope :outgoing_end, ->(outgoing_end)  {where("at <= :end_date",  {end_date: outgoing_end})}
  scope :outgoing_start, ->(outgoing_start) {where("at >= :start_date",  {start_date: outgoing_start})}

  def duration_hhmmss
    seconds = 0
    if !duration.nil?
      seconds = duration
    end
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

end
