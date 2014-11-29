desc "Manager run/stop campaign for delivery msg"

task :queue_msg => :environment do
  # get campaign by id
  campaign = Campaign.find(ENV["ID"])

  # while
  # get messages awaiting
  # check customer credit
  # send message
end
