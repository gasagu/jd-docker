FROM openjdk:8-jre

MAINTAINER ValentinDeville <contact@valentin-deville.eu>

# Create directory and start JD2 for the initial update and creation of config files.
RUN mkdir -p /opt/JDownloader/ && \
    wget -O /opt/JDownloader/JDownloader.jar --progress=bar:force http://installer.jdownloader.org/JDownloader.jar && \
    java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar

# grab tini for signal processing and zombie killing
ENV TINI_VERSION v0.18.0
RUN set -x \
        && curl -fSL "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" -o /usr/local/bin/tini \
        && curl -fSL "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc" -o /usr/local/bin/tini.asc \
        && export GNUPGHOME="$(mktemp -d)" \
        && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
        && gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
        && rm -rf "$GNUPGHOME" /usr/local/bin/tini.asc \
        && chmod +x /usr/local/bin/tini \
        && tini -h

COPY startJD2.sh /opt/JDownloader/
RUN chmod +x /opt/JDownloader/startJD2.sh

# Run this when the container is started
ENTRYPOINT ["/usr/local/bin/tini", "-g", "--"]
CMD /opt/JDownloader/startJD2.sh
