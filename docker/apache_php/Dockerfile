FROM php:8.3-apache

# Set environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1

# Set working directory
WORKDIR /app

# Expose port 80
EXPOSE 80

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -qy git unzip zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    curl -sS https://get.symfony.com/cli/installer | bash && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add aliases to .bashrc
RUN echo "alias ll='ls -alF'" >> /root/.bashrc

# PHP Extensions
RUN docker-php-ext-install -j$(nproc) opcache pdo_mysql

# PHP Configuration
COPY conf/php.ini /usr/local/etc/php/conf.d/app.ini

# Apache Configuration
COPY conf/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY conf/app.conf /etc/apache2/conf-available/app.conf

# Enable Apache modules and configurations
RUN a2enmod rewrite remoteip && a2enconf app