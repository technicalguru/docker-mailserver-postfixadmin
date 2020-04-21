FROM eu.gcr.io/long-grin-186810/rs-php:7.4.4-apache-2.4.38.0
LABEL maintainer="Ralph Schuster <github@ralph-schuster.eu>"

ARG ARG_CREATED
ARG ARG_URL
ARG ARG_SOURCE
ARG ARG_VERSION
ARG ARG_REVISION
ARG ARG_VENDOR
ARG ARG_TITLE
ARG ARG_DESCRIPTION
ARG ARG_DOCUMENTATION
ARG ARG_AUTHORS
ARG ARG_LICENSES
ARG ARG_REF_NAME

LABEL org.opencontainers.image.created=$ARG_CREATED
LABEL org.opencontainers.image.url=$ARG_URL
LABEL org.opencontainers.image.source=$ARG_SOURCE
LABEL org.opencontainers.image.version=$ARG_VERSION
LABEL org.opencontainers.image.revision=$ARG_REVISION
LABEL org.opencontainers.image.vendor=$ARG_VENDOR
LABEL org.opencontainers.image.title=$ARG_TITLE
LABEL org.opencontainers.image.description=$ARG_DESCRIPTION
LABEL org.opencontainers.image.documentation=$ARG_DOCUMENTATION
LABEL org.opencontainers.image.authors=$ARG_AUTHORS
LABEL org.opencontainers.image.licenses=$ARG_LICENSES
LABEL org.opencontainers.image.ref.name=$ARG_REF_NAME

RUN apt-get update &&  apt-get update && apt-get install -y --no-install-recommends \
    patch \
    && rm -rf /var/lib/apt/lists/*

#ADD etc/php/ /usr/local/etc/php/conf.d/
#ADD etc/conf/ /etc/apache2/conf-enabled/
#ADD etc/mods/ /etc/apache2/mods-enabled/
#ADD etc/sites/ /etc/apache2/sites-enabled/
RUN chown -R www-data:www-data /var/www/html

ENV PFA_VERSION="3.2.4"
ENV PFA_URL="https://github.com/postfixadmin/postfixadmin/archive/postfixadmin-${PFA_VERSION}.tar.gz"
RUN set -xe \
    && cd /var/www/html \
    && curl -o postfixadmin.tar.gz -L "$PFA_URL" \
    && tar --strip-components=1 -xvf postfixadmin.tar.gz \
    && rm postfixadmin.tar.gz \
    && mkdir templates_c 

ADD src/    /var/www/html/
RUN patch model/MailboxHandler.php < MailboxHandler.php.patch

RUN chown -R www-data:www-data .
