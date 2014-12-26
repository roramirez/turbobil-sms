class Rate < ActiveRecord::Base
  self.table_name = 'rate'

  validates_presence_of :provider
  validates_presence_of :route
  validates_presence_of :priority
  validates_presence_of :price

  belongs_to :provider
  belongs_to :route

  def self.get_by_outgoing(outgoing)
    # get routes
    routes = outgoing.customer.routes_by_number(outgoing.destination, false)

    #Refactor this
    rate = where(route: routes, price: outgoing.cost..Float::INFINITY)
           .order(:price)
           .first

    if rate.nil?
      rate = where(route: routes,price: 0..outgoing.cost)
             .order(price: :desc)
             .first
    end
    rate
  end


end
