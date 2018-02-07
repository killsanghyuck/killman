# Base image:
FROM ruby:2.3.1
MAINTAINER kill5038(kill5038@gmail.com)

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
 
# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/killman
RUN mkdir -p $RAILS_ROOT
 
# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT
 
# Gems:
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
 
COPY config/puma.rb config/puma.rb

ENV RAILS_ENV production
# Copy the main application.
COPY . .
ENV DATABASE_URL mysql2://kill5038:dl926516@gill-man.cppgz6vey6fn.ap-northeast-1.rds.amazonaws.com:3306/gill_man?pool=5&timeout=5000&encoding=utf8
ENV SECRET_KEY_BASE wpqkfehlfkwpqkfassaddasfat2523k5jh2jk24jl52
EXPOSE 3000

RUN RAILS_ENV=production bundle exec rake assets:precompile
# The default command that gets ran will be to start the Puma server.
CMD bundle exec puma -C config/puma.rb