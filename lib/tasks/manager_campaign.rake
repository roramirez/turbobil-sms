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

  campaigns_run = campaign_running
  campaings_actives_ids = campaigns.ids
  campaign_running.each do | r |
    if (campaings_actives_ids.include? r[:id]) == false
      pid = r[:process].to_i
      puts 'kill pid ' + pid.to_s + ' campaign ' + r[:id].to_s
      Process.kill("KILL", pid)
    end
  end

end

def campaign_running
  # get campaings running
  # return array with ids
  campaigns = []
  ps = `ps aux | grep 'queue_msg ID'| grep -v grep`
  ps.each_line do | line |
    id = line[/=([^ ]*)/,1]
    pid = line.split()[1]
    campaign = {id: id.to_i, process: pid}
    campaigns.append(campaign)
  end
  campaigns
end
