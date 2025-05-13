#!/usr/bin/env bash
set -o errexit

# Install dependencies
bundle install

# Setup database
bundle exec rake db:migrate

# Precompile assets
bundle exec rake assets:precompile
