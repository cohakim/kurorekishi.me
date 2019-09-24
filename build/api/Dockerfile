FROM ruby:2.6.4-alpine
MAINTAINER cohakim "cohakim@gmail.com"

WORKDIR /app/api
ENV RAILS_ENV production

RUN \
  apk upgrade --no-cache \
  && apk add --update --no-cache --virtual build-dependencies \
    build-base \
    linux-headers \
    mariadb-connector-c-dev \
    libxml2-dev \
    libxslt-dev \
    ruby-dev \
    ruby-json \
    yaml-dev \
    zlib-dev \
    curl-dev \
  && apk add --update --no-cache \
    bash \
    git \
    openssh \
    libxml2 \
    libxslt \
    mariadb-connector-c \
    tzdata

COPY app/base /app/base
COPY app/api/Gemfile app/api/Gemfile.lock /app/api/
RUN \
  gem install bundler \
  && echo 'gem: --no-document' >> ~/.gemrc \
  && cp ~/.gemrc /etc/gemrc \
  && chmod uog+r /etc/gemrc \
  && bundle config --global build.nokogiri --use-system-libraries \
  && bundle config --global jobs 4 \
  && bundle config --global path /usr/local/bundle

RUN bundle install --without test development

RUN apk del build-dependencies

COPY app/api /app/api
COPY build/api/entrypoint.sh /app/api/

ARG RAILS_MASTER_KEY

RUN chmod a+x entrypoint.sh
