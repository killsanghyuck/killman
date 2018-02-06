# Dockerfile
FROM seapy/ruby:2.2.0
MAINTAINER kill5038(kill5038@gmail.com)

RUN apt-get update

# Install nodejs
RUN apt-get install -qq -y nodejs

# Intall software-properties-common for add-apt-repository
RUN apt-get install -qq -y software-properties-common


# Install Mysql
ENV DEBIAN_FRONTEND noninteractive
RUN echo "mysql-client mysql-client/root_password password" | debconf-set-selections
RUN echo "mysql-client mysql-client/root_password_again password" | debconf-set-selections
RUN apt-get install -qq -y mysql-client libmysqlclient-dev

# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -qq -y nginx=1.8.0-1+trusty1
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman

## Install MySQL(for mysql, mysql2 gem)
RUN apt-get install -qq -y libmysqlclient-dev

# Install Rails App
WORKDIR /app
RUN echo "a"
RUN git clone https://github.com/macbooktroops/killman.git /app
RUN bundle install --without development test

# Add default unicorn config
ADD unicorn.rb /app/config/unicorn.rb

# Add default foreman config
ADD Procfile /app/Procfile

ENV RAILS_ENV production

CMD bundle exec rake assets:precompile && foreman start -f Procfile

ENV DATABASE_URL mysql2://kill5038:dl926516@gill-man.cppgz6vey6fn.ap-northeast-1.rds.amazonaws.com:3306/gill_man?pool=5&timeout=5000&encoding=utf8
ENV SECRET_KEY_BASE wpqkfehlfkwpqkfassaddasfat2523k5jh2jk24jl52

EXPOSE 80