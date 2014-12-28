class RateSmsService

  def execute(outgoing)

    if outgoing.provider.protocol.name == 'TWILIO'
      require 'twilio-ruby'
      # Account Sid and Auth Token for Twilio
      account_sid = outgoing.provider.username
      auth_token = outgoing.provider.password
      begin
        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.account.messages.get(outgoing.code)

        outgoing.status = message.status
        outgoing.cost = message.price.to_f.abs

        # set route, prices and prices on outgoing
        # based to provider and cost sms by rate
        rate = Rate.get_by_outgoing outgoing
        if rate.nil? == false
          outgoing.route = rate.route
          # set price for customer outgoing
          outgoing.price_for_customer = outgoing.price_customer.final_price_for_route(rate.route, rate.route.price_list)
          #decrement credit customer
          customer = Customer.find(outgoing.customer_id).decrement(:credit, outgoing.price_for_customer).save
        end

        outgoing.save
      rescue => e
        Rails.logger.warn "Unable to get rate: #{e}"
        return nil
      end
    end
  end

end
