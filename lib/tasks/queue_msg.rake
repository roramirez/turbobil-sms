desc "Manager run/stop campaign for delivery msg"

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
    if campaign.customer.enabled
      sms = contact.convert_message_text(campaign.text, columns_hash)

      # send message
      # id send
      id_sender =  SecureRandom.hex(8)
      # register on sms_queue
      q = SmsQueue.new
      q.contact = contact
      q.campaign = campaign
      q.process = Time.now
      q.save

      # register outgoing
      o = Outgoing.new
      o.provider = p
      o.text = sms
      o.customer = customer
      o.destination = contact.number
      o.contact = contact
      o.code = id_sender
      o.list = campaign.list
      o.campaign = campaign
      o.save

      sleep(1000)
    else
      return 'customer without credit'
    end
  end

end
