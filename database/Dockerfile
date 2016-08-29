FROM mysql:5.6
MAINTAINER easter1021<mufasa.hsu@gmail.com>

RUN usermod -u 1000 mysql
RUN mkdir -p /var/run/mysqld
RUN chmod -R 777 /var/run/mysqld

# 改為台北時區
RUN echo "Asia/Taipei" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata