# frozen_string_literal: true

source "https://rubygems.org"

group :production, :development do
  gem "pg", "~> 0.18.4"
end

gem "puma"
gem "rails", "~> 5.0.1"

gem "font-awesome-sass"
gem "jquery-rails", "~> 4.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", "~> 3.1"

gem "jbuilder", "~> 2.0"
gem "therubyracer", "~> 0.12.3", platforms: :ruby

gem "active-fedora", "~> 11.0.0"
gem "active-triples", "~> 0.11.0"
gem "blacklight-gallery", "~> 0.5.0"
gem "blacklight_range_limit", "~> 6.1.2"
gem "curation_concerns", "~> 1.7.7"
gem "ezid-client", "~> 1.2"
gem "hydra-role-management"
gem "linked_vocabs",
    git: "https://github.com/projecthydra-labs/linked_vocabs.git"
gem "marc"
gem "marcrel",
    git: "https://github.com/ucsblibrary/marcrel.git",
    ref: "9352b12dc478858b4b57e03dbed4ecacfa65fdbb"
gem "mods", "~> 2.0.3"
gem "openseadragon"
gem "qa", "~> 0.11.0"
gem "rdf-marmotta", "~> 0.1.1"
gem "riiif", "~> 1.1"
gem "rsolr"
gem "traject", "~> 2.3.2"

# https://github.com/amatsuda/kaminari/pull/636
gem "kaminari_route_prefix"

gem "net-ldap", "~> 0.14"
gem "settingslogic"

gem "resque-pool"
gem "resque-status"

# for bin/ingest
gem "trollop"

# When parsing the ETD metadata file from ProQuest,
# some of the dates are American-style.
gem "american_date", "~> 1.1.0"

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "factory_girl_rails", "~> 4.8"

  # Used exact gem versions for solr_wrapper and fcrepo_wrapper
  # because they aren't careful about making breaking changes on
  # minor releases, so we'll need to be mindful about upgrading.
  gem "fcrepo_wrapper", "0.7.0"
  gem "solr_wrapper", "~> 0.19.0"

  gem "poltergeist"
  gem "rspec-activemodel-mocks"
  gem "rspec-rails"
  gem "rubocop", "~> 0.49.0", require: false
  gem "rubocop-rspec", require: false
  gem "spring"
  gem "spring-commands-rspec", group: :development
end

group :test do
  gem "capybara"
  gem "ci_reporter"
  gem "database_cleaner"
  gem "rails-controller-testing"
  gem "sqlite3"
  gem "timecop"
  gem "vcr"
  gem "webmock", require: false
end

group :development do
  gem "capistrano", "~> 3.8.0"
  gem "capistrano-bundler"
  gem "capistrano-passenger"
  gem "capistrano-rails", ">= 1.1.3"
  gem "highline"

  gem "http_logger"
  gem "method_source"
  gem "pry"
  gem "pry-doc"
end
