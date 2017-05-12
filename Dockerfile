FROM ruby:2.4-alpine

MAINTAINER Hearst Automation Team <atat@hearst.com>

WORKDIR /usr/src/proxy

RUN apk update && apk add \
    bash \
    supervisor \
    git &&\
    runDeps="$( \
		scanelf --needed --nobanner --recursive /usr/local \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)" &&\
    if [ -f Gemfile.lock ]; then rm -f Gemfile.lock; fi &&\
	apk add --virtual .ruby-builddeps $runDeps \
    build-base \
    linux-headers &&\
    git clone https://github.com/theforeman/smart-proxy.git /usr/src/proxy &&\
    mkdir -p /usr/src/proxy/logs &&\
    bundle --without bmc:krb5:libvirt:puppet_proxy_legacy:test:windows &&\
    gem install smart_proxy_chef &&\
    apk del .ruby-builddeps &&\
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*

COPY supervisord.conf /usr/src/proxy/supervisord.conf
COPY proxy_start.sh /usr/local/bin/proxy_start

CMD ["supervisord", "-c", "/usr/src/proxy/supervisord.conf", "-n"]
