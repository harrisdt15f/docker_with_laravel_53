FROM phusion/baseimage
MAINTAINER easter1021 <mufasa.hsu@gmail.com>

# ...put your own build instructions here...
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y build-essential
RUN apt-get install -y re2c net-tools git unzip

# nginx
RUN apt-get install -y nginx
COPY ./nginx/vhost.conf /etc/nginx/conf.d/vhost.conf
RUN rm -Rf /etc/nginx/sites-enabled/default

# php
RUN apt-add-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y --force-yes php7.0 php7.0-cli php7.0-common php7.0-mysql php7.0-fpm php7.0-dev php7.0-zip php-xdebug
RUN apt-get install -y --force-yes php-mcrypt php7.0-soap php7.0-mbstring php7.0-intl php7.0-xml php7.0-curl php7.0-gd php7.0-json
RUN /etc/init.d/php7.0-fpm start

# PHP composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# nodejs
RUN apt-get install -y nodejs
RUN apt-get install -y npm

# supervisor
RUN apt-get install supervisor -y
COPY ./supervisor/*.conf /etc/supervisor/conf.d/
COPY ./supervisor/run_queue.sh /usr/local/bin/

# project source code
COPY ./html /var/www/html
WORKDIR /var/www/html
RUN cp -n .env.example .env
RUN rm -Rf node_modules

# composer install
RUN composer config -g repositories.packagist composer http://packagist.phpcomposer.com
RUN composer install --profile --no-dev --optimize-autoloader
RUN chown -R www-data:www-data .
RUN php artisan key:generate

# start laravel schedule
RUN /bin/bash -c 'crontab -l | { cat; echo "* * * * * php /var/www/html/artisan schedule:run >> /dev/null 2>&1"; } | crontab -'

# 改為台北時區
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN dpkg-reconfigure -fnoninteractive tzdata

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 433

# Use baseimage-docker's init system.
CMD ["/usr/bin/supervisord"]