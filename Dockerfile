FROM technicalguru/php:8.2.24-apache-2.4.62.0
LABEL maintainer="Ralph Schuster <github@ralph-schuster.eu>"

RUN apt-get update &&  apt-get update && apt-get install -y --no-install-recommends \
    patch \
    && rm -rf /var/lib/apt/lists/*

#ADD etc/php/ /usr/local/etc/php/conf.d/
#ADD etc/conf/ /etc/apache2/conf-enabled/
#ADD etc/mods/ /etc/apache2/mods-enabled/
#ADD etc/sites/ /etc/apache2/sites-enabled/
RUN chown -R www-data:www-data /var/www/html

ENV PFA_VERSION="3.3.15"
ENV PFA_REVISION="0"
ENV PFA_URL="https://github.com/postfixadmin/postfixadmin/archive/postfixadmin-${PFA_VERSION}.tar.gz"
RUN set -xe \
    && cd /var/www/html \
    && curl -o postfixadmin.tar.gz -L "$PFA_URL" \
    && tar --strip-components=1 -xvf postfixadmin.tar.gz \
    && rm postfixadmin.tar.gz \
    && mkdir templates_c 

ADD src/    /var/www/html/
#RUN patch model/MailboxHandler.php < MailboxHandler.php.patch

RUN chown -R www-data:www-data .

#####################################################################
#  Image OCI labels
#####################################################################
ARG ARG_CREATED
ARG ARG_URL=https://github.com/technicalguru/docker-mailserver-postfixadmin
ARG ARG_SOURCE=https://github.com/technicalguru/docker-mailserver-postfixadmin
ARG ARG_VERSION="${PFA_VERSION}.${PFA_REVISION}"
ARG ARG_REVISION="${PFA_REVISION}"
ARG ARG_VENDOR=technicalguru
ARG ARG_TITLE=technicalguru/mailserver-postfixadmin
ARG ARG_DESCRIPTION="Provides PostfixAdmin Web UI with Apache/PHP"
ARG ARG_DOCUMENTATION=https://github.com/technicalguru/docker-mailserver-postfixadmin
ARG ARG_AUTHORS=technicalguru
ARG ARG_LICENSES=GPL-3.0-or-later

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

