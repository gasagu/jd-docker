# MyJDownloader containerized

## Intro
This container contains the normal JDownloader 2 application. It will not run as root inside the container. Also it wont run in headless mode, because it didnt works stable on my server like this.

Before you run the container, check if you already have a My JDownloader acount. You will need it to access JDownloader from outside and to manage you downloads and settings.

## Running the container in CLI
```docker run -d --name JDownloader -v /config/jd2:/opt/JDownloader/cfg -v /home/user/Downloads:/opt/JDownloader/Downloads -e JDEMAIL=yourmail@mail -e JDPASSWORD=yourpassword -e JDDEVICENAME=yourdevicenameinmyjd gasagu/myjdownloader-docker```

## Runnint the container with Docker compose
In my opinion you have a really nice process if set the container up with plex and a shared volume. I will provide an example but at this time I didnt test this. I copied it out of my own compose files.

Your `docker-compose.yml` could look like this:

    version: '2'

    volumes:
      plex:
      media:
      jd_cfg:
     
    services:
      # Reverse Proxy
      nginx-proxy:
        restart: unless-stopped
        container_name: ReverseProxy
        image: jwilder/nginx-proxy
        ports:
          - '80:80'
          - '443:443'
        volumes:
          - /var/run/docker.sock:/tmp/docker.sock:ro
        # SSL
          - /path/to/certs:/etc/nginx/certs:ro
          - /etc/nginx/vhost.d
          - /usr/share/nginx/html
        labels:
          - com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy
     
      # Reverse Proxy SSL
      nginx-proxy-ssl:
        depends_on:
          - nginx-proxy
        image: jrcs/letsencrypt-nginx-proxy-companion
        container_name: ProxySSL
        volumes_from:
          - nginx-proxy
        volumes:
          - /path/to/certs:/etc/nginx/certs:rw
          - /var/run/docker.sock:/var/run/docker.sock:ro
        restart: unless-stopped

      # Plex Media Server
      plex:
        depends_on:
          - nginx-proxy-ssl
        container_name: Plex
        image: plexinc/pms-docker
        ports:
          - '32400:32400'
        expose:
          - '32400'
        hostname: PlexServer
        environment:
          - TZ=<YoutTimeZone>
          - ADVERTISE_IP=yourdomain.com
          - PLEX_CLAIM=####################
          - VIRTUAL_HOST=yourdomain.com
          - VIRTUAL_PORT=32400
          - LETSENCRYPT_HOST=yourdomain.com
          - LETSENCRYPT_EMAIL=your@email.com
          # - LETSENCRYPT_TEST=true You Can use this to generate a cert for a staging environment. 
        volumes:
          - plex:/config
          - plex:/transcode
          - media:/data
        restart: unless-stopped
        
      # JDownloader
      jd:
        container_name: JDownloader
        image: gasagu/jd-docker
        environment:
          - JDDEVICENAME=JD_Docker
          - JDEMAIL=########
          - JDPASSOWRD=########
        volumes:
          - jd_cfg:/opt/JDownloader/cfg
          - media:/opt/JDownloader/Downloads
        
## Accessing JDownloader from outside
Go to the [My JDownloader Webinterface](https://my.jdownloader.org/) and log in with you acount. There is also a Chrome plugin for Click'n'Load that works very well.
