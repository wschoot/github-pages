FROM alpine:latest

LABEL maintainer="fbreedijk@schubergphilis.com"

RUN apk add make g++ ruby ruby-dev && \
    gem install --no-document  jekyll github-pages jekyll-secinfo webrick bundler

WORKDIR /root/project

COPY Gemfile /root/project

#RUN gem install github-pages
RUN bundle install 

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

