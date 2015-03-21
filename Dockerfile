FROM debian:wheezy
MAINTAINER Muhammad Zamroni "halo@matriphe.com"

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.7.10-1~wheezy
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# overwrite nginx config
ADD etc/nginx.conf /etc/nginx/nginx.conf
ADD etc/conf.d/default.conf /etc/nginx/conf.d/default.conf
ADD www/index.html /usr/share/nginx/html/index.html

# clean up
RUN apt-get clean

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
