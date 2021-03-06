#!/bin/sh

# if 'masternodeprivkey' or 'externalip' does not exist it should just stop

if [ -z ${masternodeprivkey+x} ]; then
        echo "'masternodeprivkey' is unset"
        exit 1
fi
if [ -z ${externalip+x} ]; then
        echo "'externalip' is unset"
        exit 1
fi

# conf

USERNAME=$(pwgen -s 16 1)
PASSWORD=$(pwgen -s 64 1)

mkdir ~/.monoeciCore

cat << EOF > ~/.monoeciCore/monoeci.conf
rpcuser=$USERNAME
rpcpassword=$PASSWORD
rpcallowip=127.0.0.1
server=1
listen=1
daemon=1
maxconnections=24
masternode=1
masternodeprivkey=$masternodeprivkey
externalip=$externalip
addnode=201.239.210.74
addnode=80.211.15.229
addnode=80.211.160.108
addnode=80.211.188.201
addnode=212.237.14.13
addnode=80.211.69.107
addnode=80.211.69.140
addnode=80.211.166.85
addnode=80.211.83.119
addnode=80.211.102.48
addnode=80.211.102.23
addnode=80.211.231.34
addnode=80.211.162.85
addnode=194.182.85.95
addnode=212.237.31.81
EOF

# daemon

line="* * * * * cd /home/monoeci/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1"
(crontab -l; echo "$line" ) | crontab  -

sudo cron

monoecid

tail -f /dev/null
