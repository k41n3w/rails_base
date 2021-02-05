FROM ruby:2.6.6

WORKDIR /opt/app

RUN apt-get update -qq \
    && apt-get install -y curl apt-transport-https build-essential libpq-dev postgresql-client locales wget vim \
    && apt-get clean
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN echo "America/Sao_Paulo" > /etc/timezone && \
  dpkg-reconfigure -f noninteractive tzdata && \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
  echo 'LANG="pt_BR.UTF-8"'>/etc/default/locale && \
  echo 'LC_ALL="pt_BR.UTF-8"'>/etc/default/locale && \
  echo 'LANGUAGE="pt_BR.UTF-8"'>/etc/default/locale && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=pt_BR.UTF-8

ENV LC_ALL=pt_BR.UTF-8
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR.UTF-8
ENV TZ America/Sao_Paulo

COPY Gemfile /opt/app/Gemfile
COPY package.json /opt/app/package.json

RUN bundle install --verbose --jobs 20 --retry 5
RUN yarn install
