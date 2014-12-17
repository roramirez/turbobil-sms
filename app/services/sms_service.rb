class SmsService
  def execute(text, to, provider)

    if text.present? && provider.present?
      if provider.protocol.name == 'TWILIO'
        require 'twilio-ruby'
        # Account Sid and Auth Token for Twilio
        account_sid = provider.username
        auth_token = provider.password

        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.account.messages.create(:body => text,
                      :to => to,
                      :from => "+12052094747")
        return message.sid
        #return "SM11b307fb49844f159c8d9a17ef6e2f39"
      end
    end

  end
end
