FROM openjdk:8-jre

# Create directory and start JD2 for the initial update and creation of config files.
RUN mkdir -p /opt/JDownloader/Downloads && \
    adduser jdownloader --no-create-home --disabled-login --gecos "" && \
    wget -O /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
    java -jar /opt/JDownloader/JDownloader.jar -norestart && \
    chown -R jdownloader /opt/JDownloader

COPY startJD2.sh /opt/JDownloader/
RUN chmod +x /opt/JDownloader/startJD2.sh && \
    chown jdownloader /opt/JDownloader/startJD2.sh

USER jdownloader

# Run this when the container is started
WORKDIR /opt/JDownloader
ENTRYPOINT ["/opt/JDownloader/startJD2.sh"]
CMD ["java","-jar", "/opt/JDownloader/JDownloader.jar", "-norestart"]
#java -jar JDownloader.jar -norestart
