#!/bin/bash
php /var/www/html/bocat_2.0/artisan queue:work --daemon --sleep=5 --tries=1