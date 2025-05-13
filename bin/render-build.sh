#!/usr/bin/env bash
set -o errexit

# Bundle install
bundle config set --local deployment 'true'
bundle config set --local without 'development test'
bundle install

# Database setup
if [ "$RAILS_ENV" = "production" ]; then
  bundle exec rake db:migrate
else
  bundle exec rake db:setup
fi

# Asset precompilation
if [ "$RAILS_ENV" = "production" ]; then
  bundle exec rake assets:precompile
fi
