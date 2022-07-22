FROM ruby:2.7.6

ENV APP_DIR=/app

RUN apt-get update -qq

RUN mkdir -p $APP_DIR

COPY Gemfile      $APP_DIR/Gemfile
COPY Gemfile.lock $APP_DIR/Gemfile.lock

WORKDIR $APP_DIR

# Upgrade RubyGems and install latest Bundler
RUN gem update --system && \
    gem install bundler && bundle install

COPY . $APP_DIR/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve"]
