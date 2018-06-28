#!/bin/sh

echo "{\"devicename\" : \"${JDDEVICENAME}\", \"autoconnectenabledv2\" : true, \"password\" : \"${JDPASSWORD}\", \"email\" : \"${JDEMAIL}\"}" > /opt/JDownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json

exec "$@"
