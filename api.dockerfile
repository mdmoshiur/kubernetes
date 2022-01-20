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

#NEW RELIC START
# RUN \
# curl -L https://download.newrelic.com/php_agent/release/newrelic-php5-9.7.0.258-linux.tar.gz | tar -C /tmp -zx && \
# NR_INSTALL_USE_CP_NOT_LN=1 NR_INSTALL_SILENT=1 /tmp/newrelic-php5-*/newrelic-install install && \
# rm -rf /tmp/newrelic-php5-* /tmp/nrinstall* && \
# sed -i -e 's/"REPLACE_WITH_REAL_KEY"/"d93027d40543b4f7d0dab2bf8c35e802d6c53867"/' \
# -e 's/newrelic.appname = "PHP Application"/newrelic.appname = "Hermes-API"/' \
# /usr/local/etc/php/conf.d/newrelic.ini




RUN chmod +x ./deploy/api_run_live

ENTRYPOINT ["./deploy/api_run_live"]

EXPOSE 80
