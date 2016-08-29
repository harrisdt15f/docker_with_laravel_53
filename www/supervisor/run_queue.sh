#!/bin/bash
php /var/www/html/artisan queue:work --daemon --sleep=5 --tries=1