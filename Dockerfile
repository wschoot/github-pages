# Need 3.13 because of this https://stackoverflow.com/questions/68243042/you-dont-have-write-permissions-for-the-usr-lib-ruby-gems-2-7-0-directory-alp

#FROM alpine:3.13
FROM ruby:3-alpine

LABEL maintainer="fbreedijk@schubergphilis.com"

RUN apk add make g++ ruby ruby-dev 
RUN gem install --no-document jekyll 
RUN gem install --no-document github-pages 
RUN gem install --no-document jekyll-secinfo webrick bundler

WORKDIR /root/project

COPY Gemfile /root/project

#RUN gem install github-pages
RUN bundle install 

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

