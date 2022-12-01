FROM marketplace.gcr.io/google/debian11

ENV EXPORTER_VERSION 0.7.0
ENV EXPORTER_SHA256 08a0a054aecedec4aa2772569325a346403d2c1fba6f88739553416c2f4f77e6

COPY licenses/ /usr/share/doc/

RUN set -x \
        && apt-get update \
        && apt-get install -y \
                openssl \
                wget \
        && rm -rf /var/lib/apt/lists/*

RUN set -x \
        && cd /usr/local/bin \
        && wget -q -O nginx-prometheus-exporter.tar.gz "https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v$EXPORTER_VERSION/nginx-prometheus-exporter-$EXPORTER_VERSION-linux-amd64.tar.gz" \
        && wget -q -O /usr/src/nginx-prometheus-exporter-v$EXPORTER_VERSION.tar.gz "https://github.com/nginxinc/nginx-prometheus-exporter/archive/v$EXPORTER_VERSION.tar.gz" \
        && echo "${EXPORTER_SHA256} nginx-prometheus-exporter.tar.gz" | sha256sum -c - \
        && tar -xzf nginx-prometheus-exporter.tar.gz \
        && rm -f nginx-prometheus-exporter.tar.gz

RUN chmod +rx /usr/local/bin/nginx-prometheus-exporter

EXPOSE 9113

ENTRYPOINT ["/usr/local/bin/nginx-prometheus-exporter"]
