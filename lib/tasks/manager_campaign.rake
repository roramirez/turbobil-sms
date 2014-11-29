desc "Manager run/stop campaign for delivery msg"

task :manager_campaign => :environment do
  controller = ApplicationController.new
  # get actives campaign
  campaigns = Campaign.actives

  campaigns.each do |campaign|
    # get customer with credit
    if campaign.customer.enabled
    # check run/stop

      if `ps aux | grep 'queue_msg ID=#{campaign.id}'| grep -v grep` == ""
        puts 'run ' +  campaign.id.to_s
        controller.call_rake :queue_msg,  :ID => campaign.id
      else
        puts 'is running ' +  campaign.id.to_s
      end

    end
  end

end
