# Usa una imagen base de PHP con FPM
FROM php:8.2-fpm

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmariadb-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del directorio 'sac' al contenedor
COPY sac /var/www/html

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala las dependencias de Composer
RUN composer install

# Exponer el puerto 9000
EXPOSE 9000

# Comando por defecto
CMD ["php-fpm"]
