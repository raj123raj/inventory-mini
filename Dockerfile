# Multi-stage for Laravel
FROM composer:2 AS vendor
WORKDIR /var/www/html
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --optimize-autoloader

FROM php:8.3-fpm-alpine AS runtime
# Extensions for Laravel
RUN apk add --no-cache \
    libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip exif

WORKDIR /var/www/html
COPY --from=vendor /var/www/html/vendor ./vendor
COPY . .  # All Laravel files!
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
USER www-data

EXPOSE 9000
CMD ["php-fpm"]
