echo "[Info] 欢迎使用 @DuckyRoBot 一键安装脚本！官方文档：https://docs.duckybot.org"
echo "[Info] 5 秒后开始安装，您可以按下 Ctrl+C 终止本脚本！"
sleep 5
echo "[Info] 正在终止 R探长 ..."
ps -ef | grep r_client.jar | grep -v grep | awk '{print $2}' | xargs kill -9  
if [ `uname -m` = "x86_64" ] ; then
	    aarch=amd64
elif [ `uname -m` = "aarch64" ] ; then
	    aarch=arm64
else
	echo "This aarch is not supported for the time being."
    exit 1
fi
echo "[Info] 正在下载 Ducky Client，架构：$aarch ..."
wget -O /data/ducky_bot/client https://github.com/DuckyProject/DuckyRoBot/releases/latest/download/DuckyClient-${aarch}
echo "[Info] 下载完成！"
echo "[Info] 正在赋予执行权限..."
chmod +x /data/ducky_bot/client
echo "[Info] 赋予执行权限完成！"
echo "[Info] 正在尝试放行内部端口(仅甲骨文小鸡有效)..."
iptables -P INPUT ACCEPT && iptables -P OUTPUT ACCEPT &&  iptables -F && iptables-save > /etc/iptables/rules.v4 && ip6tables-save > /etc/iptables/rules.v6 
sleep 2
echo "[Info] 放行完成！"
echo "[Info] 正在写入进程守护..."
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
echo "[Info] 写入进程守护完成！"
echo "[Info] 正在创建 Conf 文件..."

echo "##### 客户端基本配置 #####" > "/data/ducky_bot/conf.ini"
echo "[Client]" > "/data/ducky_bot/conf.ini"
echo "User = $1" > "/data/ducky_bot/conf.ini"
echo "Key = $2" > "/data/ducky_bot/conf.ini"
echo "Ip =" > "/data/ducky_bot/conf.ini"
echo "Port = $3" > "/data/ducky_bot/conf.ini"
echo "" > "/data/ducky_bot/conf.ini"
echo "##### 甲骨文账号配置 #####" > "/data/ducky_bot/conf.ini"
echo "[Info] 请手动打开 /data/ducky_bot/conf.ini 添加配置！"


echo "[Info] 完成后，可以使用以下命令:"
echo "       Client 启动 : systemctl start ducky_bot"
echo "       Client 停止 : systemctl stop ducky_bot"
echo "       Client 重启 : systemctl restart ducky_bot"
echo "       Client 日志 : 1. tail -f /data/ducky_bot/DuckyClient.log"
echo "                      （Ctrl+C 终止）"
echo "                     2. 在 Ducky Bot 点击'查看实时日志'"
echo ""
echo "     感谢您对于始终免费项目的支持，有问题请反馈 Tg 群组：@DuckyGroup"
