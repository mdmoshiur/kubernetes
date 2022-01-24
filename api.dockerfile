FROM base-image:v1


COPY . /var/www/html
WORKDIR /var/www/html

RUN rm /etc/nginx/sites-enabled/default
COPY ./deploy/deploy.vhost.conf /etc/nginx/conf.d/default.conf

RUN mv /usr/local/etc/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf.backup
COPY ./deploy/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY ./deploy/custom.ini /usr/local/etc/php/conf.d/custom.ini
RUN usermod -a -G www-data root
RUN chgrp -R www-data storage

RUN chown -R www-data:www-data ./storage
RUN chmod -R 0777 ./storage

RUN chmod +x ./deploy/api_run

ENTRYPOINT ["./deploy/api_run"]

EXPOSE 80