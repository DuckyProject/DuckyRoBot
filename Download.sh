if [ `uname -m` = "x86_64" ] ; then
	    aarch=amd64
elif [ `uname -m` = "aarch64" ] ; then
	    aarch=arm64
else
	  echo "This aarch is not supported for the time being."
    exit 1
fi

#wget -O /DuckyClient/client https://github.com/DuckyProject/DuckyRoBot/releases/latest/download/DuckyClient-${aarch}
wget -O /DuckyClient/client https://pan.duckawa.me/f/nmyCQ/main%20%287%29.txt
