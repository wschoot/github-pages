FROM alpine:latest

LABEL maintainer="fbreedijk@schubergphilis.com"

RUN apk add make g++ ruby ruby-dev 
RUN gem install --no-document jekyll 
RUN gem install --no document github-pages 
RUN gem install --no document jekyll-secinfo 
RUN gem install --no document webrick 
RUN gem install --no document bundler

WORKDIR /root/project

COPY Gemfile /root/project

#RUN gem install github-pages
RUN bundle install 

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

