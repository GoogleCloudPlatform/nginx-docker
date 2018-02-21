FROM gcr.io/google-appengine/debian9

ENV NGINX_VERSION 1.13.9*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10

RUN set -x \
        if ! command -v gpg > /dev/null; then \
                apt-get update; \
                apt-get install -y --no-install-recommends \
                        gnupg \
                        wget \
                        dirmngr \
                ; \
                rm -rf /var/lib/apt/lists/*; \
        fi

RUN set -x \
	&& wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -q -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
# copy source code
	&& wget -q -O /usr/local/src/gosu.tar.gz "https://github.com/tianon/gosu/archive/$GOSU_VERSION.tar.gz" \
        && found='' \
	&& for server in \
		pool.sks-keyservers.net \
		ha.pool.sks-keyservers.net \
		pgp.mit.edu \
		na.pool.sks-keyservers.net \
		eu.pool.sks-keyservers.net \
		oc.pool.sks-keyservers.net \
		ha.pool.sks-keyservers.net \
		hkp://p80.pool.sks-keyservers.net:80 \
		hkp://keyserver.ubuntu.com:80 \
	; do \
		gpg --keyserver $server --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
			&& found="yes" && break; \
	done; test -n "$found" \
	&& echo "deb http://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list \
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

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

