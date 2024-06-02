# Sử dụng hình ảnh PHP 8.1 với FPM
FROM php:8.1-fpm

# Cài đặt các tiện ích cần thiết và các extension PHP
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql

# Cài đặt Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Thiết lập thư mục làm việc
WORKDIR /var/www

# Sao chép toàn bộ mã nguồn vào container
COPY . /var/www

# Đảm bảo quyền sở hữu đúng
RUN chown -R www-data:www-data /var/www

# Mở cổng 9000
EXPOSE 9000

# Khởi động PHP-FPM
CMD ["php-fpm"]
