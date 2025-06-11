FROM php:8.2-fpm

#Install Dependencies

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    supervisor

#Install php extensions
RUN docker-php-ext-install pdo pdo_pgsql zip

#Install Composer

COPY --from=composer:2  /usr/bin/composer  /usr/bin/composer

# Set Working directory
WORKDIR /var/www

#Add Laravel App

COPY . .

RUN composer install

#Setup Laravel 

RUN php artisan config:clear && php artisan route:clear

# Copy supervisor config for queue worker and scheduler
# COPY docker/supervisord/supervisord.conf /etc/supervisor/supervisord.conf

# CMD ["/usr/bin/supervisord"]