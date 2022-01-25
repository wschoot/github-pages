FROM ubuntu

LABEL maintainer="fbreedijk@schubergphilis.com"

# Set the timezome
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y ruby ruby-dev build-essential git locales python3-pip libcurl4 default-jre-headless
# This is needed because of known x-build issue
# https://stackoverflow.com/questions/70767396/docker-certificate-error-when-building-for-arm-v7-platform
RUN if test "$(uname -p)" == "armv7" ; then ( for i in /etc/ssl/certs/*.pem; do HASH=$(openssl x509 -hash -noout -in $i); ln -s $(basename $i) /etc/ssl/certs/$HASH.0; done ); fi
RUN gem install --no-document jekyll 
RUN gem install --no-document github-pages 
RUN gem install --no-document jekyll-secinfo jekyll-paginate jekyll-last-modified-at webrick bundler racc minitest rexml html-proofer
RUN pip3 install html5validator

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

WORKDIR /root/project

COPY Gemfile /root/project

#RUN gem install github-pages
RUN bundle install 

EXPOSE 4000

COPY jekyll.sh /root

ENTRYPOINT [ "/root/jekyll.sh" ]

