FROM ubuntu:latest

MAINTAINER MariusBelzner <mariusbelzner@gmail.com>

# Create directory and start JD2 for the initial update and creation of config files.
RUN mkdir -p /opt/JDownloader/ && \
    wget -O /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
    apt-get update && \
    apt-get install wget && \
    apt-get install oracle-java8-jdk && \
    apt-get install unrar && \
    apt-get purge wget && \
    apt-get clean

#COPY startJD2.sh /opt/JDownloader/
#RUN chmod +x /opt/JDownloader/startJD2.sh

# Run this when the container is started
#ENTRYPOINT ["/sbin/tini", "-g", "--", "/opt/JDownloader/startJD2.sh"]
#CMD ["java", "-Djava.awt.headless=true", "-jar", "/opt/JDownloader/JDownloader.jar", "-norestart"]
#java -jar JDownloader.jar -norestart
WORKDIR /opt/JDownloader
ENTRYPOINT ["/bin/bash"]
CMD ["java", "-jar", "JDownloader.jar", "-norestart"]
