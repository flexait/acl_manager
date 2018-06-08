# From one of the official ruby images
FROM ruby:2.4.3

LABEL AUTHOR=denilson.silva@flexait.com.br

ARG USER
ARG UID
ARG USER_ID
ARG APP_PATH=/var/www

RUN addgroup --gid $UID $USER && \
  adduser --system --gid $UID --uid $UID $USER && \
  mkdir -p ${APP_PATH} && \
  chown -R $USER:$USER $APP_PATH /usr/local/bundle

RUN chown -R $USER:$USER $APP_PATH

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get -y install node yarn

USER $USER
WORKDIR ${APP_PATH}/app

EXPOSE 3000

CMD bash
