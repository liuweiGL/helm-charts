#!/bin/bash
# adjust os timezone
echo 'Asia/Shanghai'  > /etc/timezone
# console相关
cd /home/clougence/cloudcanal/console/bin
su - clougence -c /home/clougence/cloudcanal/console/bin/startConsole.sh
chown -R clougence:clougence /home/clougence/cloudcanal
tail -f /dev/null