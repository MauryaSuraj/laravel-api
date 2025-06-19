FROM php:8.2-fpm

# Install system dependencies and PHP extensions in one layer
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    supervisor \
    && docker-php-ext-install pdo pdo_pgsql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy only composer files first to leverage Docker cache
COPY composer.json composer.lock ./

# Install PHP dependencies
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

# Copy the rest of the application
COPY . .

# Re-run composer to optimize autoload and run scripts
RUN composer install --optimize-autoloader --no-dev

# Laravel setup commands
RUN php artisan config:clear && php artisan route:clear

# Uncomment if using supervisor
# COPY docker/supervisord/supervisord.conf /etc/supervisor/supervisord.conf

# CMD ["/usr/bin/supervisord"]