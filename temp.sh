sudo kill -9 $(sudo lsof -t -i:8088)

if [ `uname -m` = "x86_64" ] ; then
	    aarch=amd64
elif [ `uname -m` = "aarch64" ] ; then
	    aarch=arm64
else
	  echo "This aarch is not supported for the time being."
    exit 1
fi

wget -O /data/ducky_bot/client https://github.com/DuckyProject/DuckyRoBot/releases/latest/download/DuckyClient-${aarch}

cat >/etc/systemd/system/ducky_bot.service <<EOF
[Unit]
Description=ducky_bot
Documentation=https://docs.duckybot.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=/data/ducky_bot
ExecStart=/data/ducky_bot/client
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target
EOF

systemctl enable ducky_bot
systemctl restart ducky_bot
