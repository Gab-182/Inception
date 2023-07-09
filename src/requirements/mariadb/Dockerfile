FROM debian:bullseye-slim

ARG MYSQL_ADMIN
ARG MYSQL_DATABASE
ARG MYSQL_PASSWORD
ARG MYSQL_USER
ARG MYSQL_ADMIN_PASSWORD
ARG MYSQL_ROOT_PASSWORD


# Update the package manager and install necessary tools
RUN apt-get update && apt-get install \
    mariadb-server \
    mariadb-client -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/mysql
RUN chown -R mysql:mysql /var/run/mysql
RUN chmod 777 /var/run/mysql

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb start && \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" && \
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e"FLUSH PRIVILEGES;" && \
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
                                               CREATE USER IF NOT EXISTS '$MYSQL_ADMIN'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD'; \
                                               GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN'@'%'; \
                                               CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
                                               GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'; \
                                               FLUSH PRIVILEGES;"



EXPOSE 3306

# Start the MariaDB daemon with:
CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0"]