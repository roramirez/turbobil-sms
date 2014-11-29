desc "Manager run/stop campaign for delivery msg"

task :manager_campaign => :environment do
  # get actives campaign
  campaigns = Campaign.actives

  campaigns.each do |campaign|
    # get customer with credit
    if campaign.customer.enabled
    # check run/stop
      puts 'run ' +  campaign.id.to_s
    end
  end

end
