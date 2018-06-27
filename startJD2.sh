#!/bin/bash

echo "{\"devicename\" : \"${JDDEVICENAME}\", \"autoconnectenabledv2\" : true, \"password\" : \"${JDPASSWORD}\", \"email\" : \"${JDEMAIL}\"}" > /opt/JDownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json

exec java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar -norestart
