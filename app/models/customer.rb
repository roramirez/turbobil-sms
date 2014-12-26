class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :rememberable, :trackable, :validatable
  include CustomerHelper
  self.table_name = 'customer'

  validates_presence_of :name
  validates_presence_of :type_pay

  validates :password, presence: true, on: :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_many :outgoings
  has_many :campaigns
  has_many :lists

  belongs_to :customer
  belongs_to :currency
  belongs_to :admin
  belongs_to :type_customer
  belongs_to :price_customer

  def type_pay_label
    type_payment type_pay
  end

  def minutes_outgoing_last_days(days=7)
    Outgoing.where(customer: self)
        .where("at >= ?", Time.now - days.days)
        .group('DATE(at)')
        .sum(:duration)
  end

  def enabled
    is_enabled = false
    if type_pay == 1
      if credit > 0
        is_enabled = true
      end
    elsif type_pay == 2
      is_enabled = true
    end
    is_enabled
  end

  def routes_by_number(number, limit_one = true)
    for i in 0..number.length
      prefix = number[0, number.length - i]
      if limit_one
        r = admin.routes.where(prefix: prefix).limit(1)  #FIXME: #uggly fix
      else
        r = admin.routes.where(prefix: prefix)
      end
      if r.count > 0
        return r
      end
    end
  end

  def rates(number)
    routes = routes_by_number(number)
    p = Provider.where(admin: admin)
    Rate.where(route: routes, provider: p)
  end

end
