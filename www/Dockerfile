FROM phusion/baseimage
MAINTAINER easter1021 <mufasa.hsu@gmail.com>

ENV BUILD_DEPS \
        wget \
        build-essential \
        re2c \
        net-tools \
        git \
        libmemcached-dev \
        unzip

ENV NGINX_DEPS \
        nginx

ENV PHP56_DEPS \
        php5.6 \
        php5.6-cli \
        php5.6-common \
        php5.6-mysql \
        php5.6-fpm \
        php5.6-dev \
        php5.6-zip \
        php-xdebug \
        php5.6-mcrypt \
        php5.6-soap \
        php5.6-mbstring \
        php5.6-intl \
        php5.6-xml \
        php5.6-curl \
        php5.6-gd \
        php5.6-json

ENV NODEJS_DEPS \
        nodejs \
        npm

ENV PHP_MEMCACHED \
        git clone https://github.com/php-memcached-dev/php-memcached.git /usr/src/php/ext/memcached \
        && cd /usr/src/php/ext/memcached \
            && docker-php-ext-configure memcached \
            && docker-php-ext-install memcached \

# ...put your own build instructions here...
RUN set -xe && \
        LANG=C.UTF-8 add-apt-repository ppa:ondrej/php && \
        apt-get update && apt-get install -y --force-yes --no-install-recommends --no-install-suggests \
            $BUILD_DEPS \
            $NGINX_DEPS \
            $PHP56_DEPS \
            $NODEJS_DEPS \
            supervisor \
        && $PHP_MEMCACHED \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# nginx
COPY ./nginx/vhost.conf /etc/nginx/conf.d/vhost.conf
RUN rm -Rf /etc/nginx/sites-enabled/default

# install phpunit
RUN curl https://phar.phpunit.de/phpunit.phar -L > phpunit.phar \
  && chmod +x phpunit.phar \
  && mv phpunit.phar /usr/local/bin/phpunit \
  && phpunit --version

# php
RUN /etc/init.d/php5.6-fpm start

# PHP composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
        php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
        php composer-setup.php --install-dir=/usr/bin --filename=composer && \
        php -r "unlink('composer-setup.php');"

# supervisor
COPY ./supervisor/*.conf /etc/supervisor/conf.d/
COPY ./supervisor/run_queue.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run_queue.sh

# project source code
#COPY ./html /var/www/html
#WORKDIR /var/www/html/bocat_2.0
#RUN cp -n .env.example .env
#RUN rm -Rf node_modules

# composer install
#RUN composer config -g repositories.packagist composer http://packagist.phpcomposer.com
#RUN composer install --profile --no-dev --optimize-autoloader
#RUN chown -R www-data:www-data .
#RUN php artisan key:generate

# start laravel schedule
RUN /bin/bash -c 'crontab -l | { cat; echo "* * * * * php /var/www/html/bocat_2.0/artisan schedule:run >> /dev/null 2>&1"; } | crontab -'

# 改为上海时间
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && dpkg-reconfigure -fnoninteractive tzdata

EXPOSE 80 433 9000

# Use baseimage-docker's init system.
CMD ["/usr/bin/supervisord"]
