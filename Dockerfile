FROM ubuntu

LABEL maintainer="fbreedijk@schubergphilis.com"

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "Europe/Amsterdam" > /etc/timezone && \
    apt-get update && \
    apt-get install -y ruby ruby-dev build-essential git locales
RUN gem install --no-document jekyll 
RUN gem install --no-document github-pages 
RUN gem install --no-document jekyll-secinfo jekyll-paginate  webrick bundler racc minitest rexml 
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

