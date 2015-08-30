#! /bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
/usr/bin/env
cd /home/turbobil/deploy/app/current
# Run Task
bin/rake manager_campaign RAILS_ENV=production
bin/rake check_sms_status RAILS_ENV=production

