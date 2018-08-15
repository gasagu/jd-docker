FROM openjdk:8-jre

# Create directory and start JD2 for the initial update and creation of config files.
RUN mkdir -p /opt/JDownloader/Downloads && \
    adduser jdownloader --no-create-home --disabled-login --gecos "" && \
    wget -O /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
    java -jar /opt/JDownloader/JDownloader.jar -norestart && \
    chown -R jdownloader /opt/JDownloader

COPY startJD2.sh /opt/JDownloader/
COPY sevenzipjbinding1509.jar /opt/JDownloader/libs/
COPY sevenzipjbinding1509Linux.jar /opt/JDownloader/libs/
RUN chmod +x /opt/JDownloader/startJD2.sh && \
    chown -R jdownloader /opt/JDownloader/startJD2.sh

USER jdownloader
WORKDIR /opt/JDownloader

# Run this when the container is started
ENTRYPOINT ["/opt/JDownloader/startJD2.sh"]
CMD ["java","-jar", "/opt/JDownloader/JDownloader.jar", "-norestart"]
