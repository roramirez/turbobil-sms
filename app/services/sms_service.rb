class SmsService
  def execute(text, to, provider)

    if text.present? && provider.present?
      if provider.protocol.name == 'TWILIO'
        require 'twilio-ruby'
        # Account Sid and Auth Token for Twilio
        account_sid = provider.username
        auth_token = provider.password

        begin
          @client = Twilio::REST::Client.new account_sid, auth_token
          message = @client.account.messages.create(:body => text,
                        :to => to,
                        :from => "+12052094747")
          return message.sid
        rescue => e
          Rails.logger.warn "Unable to sms send, will ignore: #{e}"
          return nil
        end
      end
    end

  end
end
