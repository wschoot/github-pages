FROM alpine:latest

LABEL maintainer="fbreedijk@schubergphilis.com"

RUN apk add make g++ ruby ruby-dev && \
    gem install --no-document  jekyll github-pages jekyll-secinfo webrick

WORKDIR /srv/jekyll

#COPY Gemfile /srv/jekyll

#RUN gem install github-pages
#RUN bundle install 

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

