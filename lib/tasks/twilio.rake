require 'twilio-ruby'

desc "Twilio"

task :twilio => :environment do

# Get your Account Sid and Auth Token from twilio.com/user/account
account_sid = ''
auth_token = ''

@client = Twilio::REST::Client.new account_sid, auth_token

message = @client.account.messages.create(:body => '',
  :to => "+56974766486",
  :from => "+12052094747")
puts message.sid

end
