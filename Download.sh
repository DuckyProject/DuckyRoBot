if [ `uname -m` = "x86_64" ] ; then
	    aarch=amd64
elif [ `uname -m` = "aarch64" ] ; then
	    aarch=arm64
else
	  echo "This aarch is not supported for the time being."
    exit 1
fi

wget -O /data/ducky_bot/client https://github.com/DuckyProject/DuckyRoBot/releases/latest/download/DuckyClient-${aarch}
