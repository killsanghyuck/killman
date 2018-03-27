# Base image:
FROM ruby:2.3.1
MAINTAINER kill5038(kill5038@gmail.com)

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# Set an environment variable where the Rails app is installed to inside of Docker image:
RUN mkdir -p /killman
# Set working directory, where the commands will be ran:
WORKDIR /killman
# Gems:
COPY Gemfile /killman/Gemfile
COPY Gemfile.lock /killman/Gemfile.lock
RUN gem install bundler
RUN bundle install --jobs 20 --retry 5 --without development test

ENV RAILS_ENV production
ENV RACK_ENV production

ENV DATABASE_URL mysql2://kill5038:dl926516@gill-man.cppgz6vey6fn.ap-northeast-1.rds.amazonaws.com:3306/gill_man?pool=5&timeout=5000&encoding=utf8
ENV SECRET_KEY_BASE wpqkfehlfkwpqkfassaddasfat2523k5jh2jk24jl52

COPY . /killman
RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]