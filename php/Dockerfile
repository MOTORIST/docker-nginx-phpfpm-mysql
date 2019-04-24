FROM php:7.2-fpm

ARG APP_ENV="prod"

RUN echo "********** APP_ENV - ${APP_ENV} *************"

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
	    libcurl4-gnutls-dev \
        openssl \
        libmagickwand-dev \
	&& docker-php-ext-configure gd \
		--with-gd \
		--with-freetype-dir=/usr/include/ \
		--with-png-dir=/usr/include/ \
		--with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-configure pdo_mysql --with-pdo-mysql \
	&& docker-php-ext-configure mbstring --enable-mbstring \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        mbstring \
        curl \
        zip \
        gd \
        sockets \
        exif \
	&& pecl install \
		imagick \
		redis-4.3.0 \
    && docker-php-ext-enable redis imagick

# Install Deployer
RUN curl -LO https://deployer.org/deployer.phar \
    && mv deployer.phar /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

# Install Xdebug
RUN if [ $APP_ENV = "dev" ] ; then \
        pecl install xdebug-2.7.0 \
        && docker-php-ext-enable xdebug; \
fi

#Clean
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*


#set timezone
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
