FROM debian:testing-slim

MAINTAINER Zachary Elliott <contact@zell.io>

RUN apt-get update && \
    apt-get install -y nginx syslog-ng ruby build-essential ruby-dev && \
    gem install --no-document bundler && \
    useradd --home-dir /var/lib/builder --user-group --create-home --system --uid 999 --shell /bin/false builder

ADD . /usr/src/site

RUN chown -R builder:builder /var/lib/builder /usr/src/site

USER builder

RUN cd /usr/src/site && \
    bundle install --path vendor/bundle --with development && \
    bundle exec rake generate

USER root

RUN mv /usr/src/site/public /srv/http && \
    mv /usr/src/site/cloudbuild/nginx.conf /etc/nginx/nginx.conf && \
    mv /usr/src/site/cloudbuild/entry-point.sh /usr/local/sbin/entry-point.sh && \
    chown -R www-data:www-data /srv/http && \
    chmod -R uoga-w /srv/http && \
    rm -R /usr/src/site && \
    apt-get -y purge ruby build-essential ruby-dev && \
    apt-get -y autoremove

EXPOSE 80

ENTRYPOINT [ "/usr/local/sbin/entry-point.sh" ]
