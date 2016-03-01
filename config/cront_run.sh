#! /bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
# kill process take much time
ps -eoetime,pid,user,cmd --sort -etime|egrep "check_|manager_cam|scripts"|awk 'int(substr($1,1,index($1,":"))) >= 2 { print $2}' |  xargs -l kill -9 $1
/usr/bin/env
cd /home/turbobil/deploy/app/current
# Run Task
bin/rake manager_campaign RAILS_ENV=production
bin/rake check_sms_status RAILS_ENV=production

