FROM debian:bullseye-slim

# Passing the important variable from .env to entrypoint script.
ARG URL
ARG WORDPRESS_DB_HOST
ARG WORDPRESS_DB_USER
ARG WORDPRESS_DB_PASSWORD
ARG WORDPRESS_USER_EMAIL
ARG WORDPRESS_DB_NAME
ARG WORDPRESS_DB_ADMIN
ARG WORDPRESS_DB_ADMIN_PASS

# Install required packages
RUN apt-get update && apt-get install -y \
    php-fpm     \
    php-mysql   \
    php-curl    \
    php-gd      \
    php-zip     \
    wget        \
    curl        \
    sendmail    \
    unzip       \
    php7.4-mysql

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY conf/wp-config.php ./
COPY tools/static_site/ ./static_site/

# Expose port 9000 for php-fpm
EXPOSE 9000

# Copy and run entrypoint
COPY ./tools/entrypoint.sh ./
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]