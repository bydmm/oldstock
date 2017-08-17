FROM ruby:2.4.1

RUN apt-get update
RUN apt-get install -y --force-yes -V \
    git curl zlib1g-dev build-essential \
    libssl-dev libcurl4-openssl-dev \
    libyaml-dev htop \
    libmysqlclient-dev
