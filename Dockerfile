FROM jekyll/jekyll:latest

LABEL maintainer="fbreedijk@schubergphilis.com"

RUN apk update && \
apk upgrade


WORKDIR /srv/jekyll

COPY Gemfile /srv/jekyll

#RUN gem install github-pages
RUN bundle install 

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

