FROM ruby:2.4.1

COPY ./sources.list /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y --force-yes -V \
    git curl htop \
    zlib1g-dev build-essential \
    libssl-dev libcurl4-openssl-dev \
    libyaml-dev libmysqlclient-dev \
    && apt-get clean

ENV APP_HOME /app

RUN mkdir $APP_HOME

COPY ./app/Gemfile* $APP_HOME/

RUN cd $APP_HOME/ \
    && bundle install

COPY ./app $APP_HOME

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["run"]
