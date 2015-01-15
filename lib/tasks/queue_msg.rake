desc "delivery msg for queue on campaign"

task :queue_msg => :environment do
  # get campaign by id
  campaign = Campaign.find(ENV["ID"])
  # get customer
  customer = campaign.customer

  # get messages awaiting
  queue = campaign.get_sms_pending
  columns_hash = campaign.list.columns_hash
  queue.each do | contact |
    # check customer credit
    if customer.enabled
      sms = contact.convert_message_text(campaign.text, columns_hash)

      routes = customer.rates(contact.number)
      routes.each do | route |
        # send message
        id_sender = SmsService.new.execute(sms, contact.number, route.provider)
        # register outgoing
        o = Outgoing.new
        o.provider = route.provider
        o.text = sms
        o.customer = customer
        o.destination = contact.number
        o.contact = contact
        o.code = id_sender
        o.list = campaign.list
        o.campaign = campaign
        o.at = Time.now
        o.price_customer_id = customer.price_customer_id
        o.admin = customer.admin
        o.save

        if id_sender
          # register on sms_queue
          q = SmsQueue.new
          q.contact = contact
          q.campaign = campaign
          q.process = Time.now
          q.save
          sleep(5)
          RateSmsService.new.execute(o)
          break
        end

      end

      sleep(3)
      customer = Customer.find(customer.id)
    else
      return 'customer without credit'
    end
  end

end
