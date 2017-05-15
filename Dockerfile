FROM ruby:2.4-alpine

MAINTAINER Hearst Automation Team <atat@hearst.com>

WORKDIR /usr/src/proxy

COPY ./* /tmp/

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
    curl \
    unzip \
    linux-headers &&\
    git clone https://github.com/theforeman/smart-proxy.git /usr/src/proxy &&\
    mv /tmp/proxy_start.sh /usr/local/bin/proxy_start &&\
    mv /tmp/supervisord.conf /usr/src/proxy/supervisord.conf &&\
    mkdir -p /usr/src/proxy/logs &&\
    ln -s /usr/src/proxy/config/settings.d/ /usr/src/proxy/settings.d &&\
    curl -LJO https://github.com/theforeman/smart_proxy_chef/archive/master.zip &&\
    unzip smart_proxy_chef-master.zip 'smart_proxy_chef-master/lib/*' -d /tmp &&\
    mv /tmp/smart_proxy_chef-master/lib/ ./lib/ &&\
    rm -f smart_proxy_chef-master.zip &&\
    bundle --without bmc:krb5:libvirt:puppet_proxy_legacy:test:windows &&\
    apk del .ruby-builddeps &&\
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*

CMD ["supervisord", "-c", "/usr/src/proxy/supervisord.conf", "-n"]
