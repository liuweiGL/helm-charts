#!/bin/bash
# adjust os timezone
echo 'Asia/Shanghai'  > /etc/timezone
# console相关
cd /home/eastcoal-docker/cloudcanal/console/bin
su - clougence -c /home/eastcoal-docker/cloudcanal/console/bin/startConsole.sh
chown -R clougence:clougence /home/eastcoal-docker/cloudcanal
tail -f /dev/null