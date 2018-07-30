FROM mysql:5.6
MAINTAINER easter1021<mufasa.hsu@gmail.com>

RUN set -xe && \
        usermod -u 1000 mysql && \
        mkdir -p /var/run/mysqld && \
        chmod -R 777 /var/run/mysqld && \

        # 改为中国时间
        echo "Asia/Shanghai" > /etc/timezone && \
        dpkg-reconfigure --frontend noninteractive tzdata
