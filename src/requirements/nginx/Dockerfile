FROM debian:bullseye-slim

ARG CERTIFICATE
ARG PRIVATE_KEY

RUN apt-get update && apt-get install -y nginx curl openssl

RUN mkdir -p /etc/nginx/ssl/

COPY ./conf/fastcgi_params /etc/nginx/fastcgi_params
COPY ./conf/inception.conf /etc/nginx/sites-available/

# Create a symbolic link to the inception.conf file in the /etc/nginx/sites-enabled
# from the /etc/nginx/sites-available .
RUN ln -s /etc/nginx/sites-available/inception.conf /etc/nginx/sites-enabled/inception.conf && \
	rm -rf /etc/nginx/sites-enabled/default && \
	rm -rf /etc/nginx/sites-available/default

EXPOSE 443

# Copy and run entrypoint
COPY ./tools/entrypoint.sh ./
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]