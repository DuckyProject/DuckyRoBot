
if [ `uname -m` = "x86_64" ] ; then
    aarch=amd64
elif [ `uname -m` = "aarch64" ] ; then
    aarch=arm64
else
    echo "This aarch is not supported for the time being."
    exit 1
fi

wget -O /data/ducky_bot/updater https://github.com/DuckyProject/DuckyRoBot/raw/main/updater-${aarch}
chmod +x /data/ducky_bot/updater
cat >/etc/systemd/system/ducky_update.service <<EOF
[Unit]
Description=ducky_bot
Documentation=https://docs.duckybot.me

[Service]
Type=simple
WorkingDirectory=/data/ducky_bot
ExecStart=/data/ducky_bot/updater
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF

systemctl enable ducky_update

