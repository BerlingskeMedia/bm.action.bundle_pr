FROM berlingskemedia/bm.docker.php.perftest:testing-latest

RUN DEBIAN_FRONTEND=noninteractive \
    && curl -sSL http://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > \
        /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update --yes --quiet \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet \
        logrotate \
        php7.2-sqlite3 \
        php7.2-zip \
        php-xdebug \
        unzip \
        imagemagick \
        php-imagick \
        wget \
        ant \
        git \
        cron \
        vim \
        npm \
        jq \
        rsyslog \
        google-chrome-stable

RUN rm -f /etc/php/7.2/cli/conf.d/05-opcache.ini
RUN rm -f /etc/php/7.2/fpm/conf.d/05-opcache.ini
RUN curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
    && echo 'deb http://deb.nodesource.com/node_10.x xenial main' > /etc/apt/sources.list.d/nodesource.list \
    && echo 'deb-src http://deb.nodesource.com/node_10.x xenial main' >> /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get -y install nodejs
RUN npm i -g npm@6.4.1
RUN npm install -g typescript
RUN composer self-update

RUN echo '//registry.npmjs.org/:_authToken=${1}' > /etc/npmrc

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

#CMD ["composer", "install"]
#CMD ["php-fpm7.2", "--nodaemonize", "--fpm-config", "/etc/php/7.2/fpm/php-fpm.conf"]
