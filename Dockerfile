FROM ubuntu
MAINTAINER kill5038(kill5038@gmail.com)

# Run upgrades
RUN apt-get update

# Install basic packages
RUN apt-get -qq -y install git curl build-essential openssl libssl-dev python-software-properties python g++ make
RUN apt-get -qq -y install libsqlite3-dev
RUN apt-get -qq -y install nodejs

# Install Mysql
ENV DEBIAN_FRONTEND noninteractive
RUN echo "mysql-client mysql-client/root_password password" | debconf-set-selections
RUN echo "mysql-client mysql-client/root_password_again password" | debconf-set-selections
RUN apt-get install -qq -y mysql-client libmysqlclient-dev

# Install Ruby
RUN apt-get -qq -y install ruby-full
RUN gem install bundler --no-ri --no-rdoc
RUN gem install foreman compass

# Install charmbitHair
WORKDIR /app
RUN echo "a"
RUN git clone https://github.com/macbooktroops/killman.git /app
RUN bundle install --without development test

# Run charmbitHair
ENV SECRET_KEY_BASE wpqkfehlfkwpqkfassaddasfat2523k5jh2jk24jl52
ENV RAILS_ENV production
EXPOSE 80
CMD foreman start -f Procfile