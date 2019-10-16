# WARNING: This Dockerfile installs NGINX Prometheus Exporter and should be used
# only in versions 1.14.x and 1.15.x. For newest version of NGINX, use template
# that doesn't install exporter and use exporter as sidecar.
# For more information, see exporter directory.

FROM gcr.io/google-appengine/debian9

ENV NGINX_VERSION 1.17.5*
ENV C2D_RELEASE 1.17.5
ENV EXPORTER_VERSION 0.4.2

RUN set -x \
        && apt-get update \
        && apt-get install -y \
                dirmngr \
                gnupg \
                wget \
        && rm -rf /var/lib/apt/lists/*

RUN set -x \
        && echo "deb http://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list \
        && wget http://nginx.org/packages/keys/nginx_signing.key \
        && apt-key add nginx_signing.key \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                                                ca-certificates \
                                                nginx=${NGINX_VERSION} \
                                                nginx-module-xslt=${NGINX_VERSION} \
                                                nginx-module-geoip=${NGINX_VERSION} \
                                                nginx-module-image-filter=${NGINX_VERSION} \
                                                nginx-module-perl=${NGINX_VERSION} \
                                                nginx-module-njs=${NGINX_VERSION} \
                                                gettext-base \
        && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

COPY stub.conf /etc/nginx/conf.d/stub.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +rx /usr/local/bin/nginx-prometheus-exporter
RUN chmod +rx /usr/local/bin/docker-entrypoint.sh

COPY licences/ /usr/share/doc/

# 9113 - port for prometheus metrics
EXPOSE 80 443 9113

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
