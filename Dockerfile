FROM ruby:latest

LABEL maintainer="fbreedijk@schubergphilis.com"

RUN apt-get update && apt-get install -y locales && \
locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8 && \
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

WORKDIR /root/project

RUN gem install bundler && \
mkdir -p .bundle-cache && \
gem install github-pages

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

