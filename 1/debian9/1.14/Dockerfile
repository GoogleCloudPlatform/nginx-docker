FROM gcr.io/google-appengine/debian9

ENV NGINX_VERSION 1.14.2*
ENV DOC_DIR /usr/share/doc

RUN set -x \
        && apt-get update \
        && apt-get install -y \
                dirmngr \
                gnupg \
                wget \
        && rm -rf /var/lib/apt/lists/*

RUN set -x \
        && echo "deb http://nginx.org/packages/debian/ stretch nginx" >> /etc/apt/sources.list \
        && wget http://nginx.org/packages/keys/nginx_signing.key \
        && apt-key add nginx_signing.key \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                                                ca-certificates \
                                                nginx=${NGINX_VERSION} \
                                                nginx-module-xslt \
                                                nginx-module-geoip \
                                                nginx-module-image-filter \
                                                nginx-module-perl \
                                                nginx-module-njs \
                                                gettext-base \
        && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx-prometheus-exporter /usr/local/bin/nginx-prometheus-exporter
COPY stub.conf /etc/nginx/conf.d/stub.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +rx /usr/local/bin/nginx-prometheus-exporter
RUN chmod +rx /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p ${DOC_DIR}/nginx-prometheus-exporter
RUN mkdir -p ${DOC_DIR}/nginxinc/nginx-plus-go-sdk
RUN mkdir -p ${DOC_DIR}/prometheus/client_golang
RUN mkdir -p ${DOC_DIR}/beorn7/perks
RUN mkdir -p ${DOC_DIR}/golang/protobuf
RUN mkdir -p ${DOC_DIR}/matttproud/golang_protobuf_extensions

COPY Licences/nginx-prometheus-exporter/* ${DOC_DIR}/nginx-prometheus-exporter
COPY Licences/nginxinc/nginx-plus-go-sdk/* ${DOC_DIR}/nginxinc/nginx-plus-go-sdk
COPY Licences/prometheus/client_golang/* ${DOC_DIR}/prometheus/client_golang
COPY Licences/beorn7/perks/* ${DOC_DIR}/beorn7/perks
COPY Licences/golang/protobuf/* ${DOC_DIR}/golang/protobuf
COPY Licences/matttproud/golang_protobuf_extensions/* ${DOC_DIR}/matttproud/golang_protobuf_extensions

# 9113 - port for prometheus metrics
EXPOSE 80 443 9113

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
