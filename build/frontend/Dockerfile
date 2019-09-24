FROM ruby:2.6.4-alpine
MAINTAINER cohakim "cohakim@gmail.com"

WORKDIR /app/frontend
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
    nodejs \
    yarn \
    tzdata

COPY app/shared /app/shared
COPY app/frontend/Gemfile app/frontend/Gemfile.lock /app/frontend/
RUN \
  gem install bundler \
  && echo 'gem: --no-document' >> ~/.gemrc \
  && cp ~/.gemrc /etc/gemrc \
  && chmod uog+r /etc/gemrc \
  && bundle config --global build.nokogiri --use-system-libraries \
  && bundle config --global jobs 4 \
  && bundle config --global path /usr/local/bundle
RUN bundle install --without test development

ARG RAILS_MASTER_KEY
ARG SECRET_KEY_BASE

COPY app/frontend/package.json /app/frontend/
COPY app/frontend/yarn.lock /app/frontend/
RUN bundle exec yarn install --check-files
RUN bundle exec yarn install
RUN bundle exec rails assets:precompile

RUN apk del build-dependencies

COPY app/frontend /app/frontend
COPY build/frontend/entrypoint.sh /app/frontend/

RUN chmod a+x entrypoint.sh
