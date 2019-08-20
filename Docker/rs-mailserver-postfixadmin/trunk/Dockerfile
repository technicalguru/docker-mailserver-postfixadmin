FROM eu.gcr.io/long-grin-186810/rs-php:7.3.6-apache-2.4.25.0
MAINTAINER Ralph Schuster <github@ralph-schuster.eu>

ADD etc/php/ /usr/local/etc/php/conf.d/
ADD etc/conf/ /etc/apache2/conf-enabled/
ADD etc/mods/ /etc/apache2/mods-enabled/
ADD etc/sites/ /etc/apache2/sites-enabled/
ADD src/    /var/www/html/
RUN chown -R www-data:www-data /var/www/html

RUN cd /var/www/html \
    && curl -o postfixadmin.tar.gz https://netcologne.dl.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-3.2/postfixadmin-3.2.tar.gz \
    && tar --strip-components=1 -xzvf postfixadmin.tar.gz \
    && rm postfixadmin.tar.gz \
    && mkdir templates_c \
    && chown -R www-data:www-data .


