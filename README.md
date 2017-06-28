# MyJDownloader

## Running the container
```docker run -d --name jd2 -v /config/jd2:/opt/JDownloader/cfg -v /home/user/Downloads:/root/Downloads -e JDEMAIL=yourmail@mail -e JDPASSWORD=yourpassword -e JDDEVICENAME=yourdevicenameinmyjd mythevalentinus/myjdownloader-docker```
