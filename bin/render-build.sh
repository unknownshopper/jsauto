#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Compile assets
BUNDLE_WITHOUT=development:test bundle exec rake assets:precompile

# Set up database
bundle exec rake db:migrate
bundle exec rake db:seed
