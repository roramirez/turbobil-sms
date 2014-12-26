desc "delivery msg for queue on campaign"

task :rate_out => :environment do

  o = Outgoing.find(21)
  RateSmsService.new.execute(o)
end
