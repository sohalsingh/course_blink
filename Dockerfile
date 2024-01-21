FROM ruby:3.1.0

RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
  build-essential nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN apt install imagemagick libvips

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
