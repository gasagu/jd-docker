#!/bin/bash

function stopJD2 {
	PID=$(cat JDownloader.pid)
	kill $PID
	wait $PID
	exit
}

trap stopJD2 EXIT

echo "{\"devicename\" : \"${JDDEVICENAME}\", \"autoconnectenabledv2\" : true, \"password\" : \"${JDPASSWORD}\", \"email\" : \"${JDEMAIL}\"}" > /opt/JDownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json

java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar &

while true; do
	sleep inf
done

