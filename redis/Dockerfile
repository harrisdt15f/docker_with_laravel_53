FROM redis:latest
MAINTAINER easter1021(Charles) <mufasa.hsu@gmail.com>

# 改为中国时间
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
