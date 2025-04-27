I'll help create a plan to upgrade this Rails application to the latest version (Rails 7.1.x). Here's a detailed upgrade plan based on reviewing the codebase:

# Rails Upgrade Plan

## Phase 1: Initial Assessment & Preparation

1. Current State:
- Running on Rails 6.0
- Ruby version 3.0.0
- Using PostgreSQL database
- Main gems: rspec-rails, rspec-given, radix, text

2. Preparatory Steps:
- Update `.ruby-version` to 3.2.2 (latest stable Ruby version supported by Rails 7.1)
- Create a new git branch for the upgrade
- Update bundler to the latest version
- Make a backup of the database

## Phase 2: Initial Dependency Updates

1. Update Gemfile:
```ruby
source 'https://rubygems.org'

gem 'rails', '~> 7.1.0'
gem 'pg'
gem 'radix', '~> 2.1.1'

# Update test gems
group :test, :development do
  gem 'rspec-rails', '~> 6.0'
  gem 'rspec-given'
  gem 'text', '~> 1.3'
end
```

2. Run `bundle update`

## Phase 3: Configuration Updates

1. Update `config/application.rb`:
```ruby
require_relative "boot"
require "rails/all"
# OR keep the minimal setup:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"

Bundler.require(*Rails.groups)

module Shrinkwrap
  class Application < Rails::Application
    config.load_defaults 7.1
    config.active_record.verify_foreign_keys_for_fixtures = false
  end
end
```

2. Update environment files:
- Remove deprecated config options from `config/environments/*.rb`
- Update `config.eager_load` settings
- Update asset handling configurations

3. Update `config/initializers`:
- Remove `wrap_parameters.rb` if not needed
- Update `secret_token.rb` to only use `secret_key_base`
- Check other initializers for deprecated syntax

## Phase 4: Code Updates

1. Controller Updates:
- Update `ShortUrlsController`:
  - Replace `render plain:` with `render plain:`
  - Update strong parameters usage if needed

2. Model Updates:
- Update ActiveRecord callbacks if any
- Check for deprecated finder methods
- Update any custom validations

3. Test Updates:
- Update RSpec configuration in `spec_helper.rb`
- Update deprecated test syntax
- Update test configurations for Rails 7.1

## Phase 5: Security Updates

1. Update Cross-Origin Resource Sharing (CORS) configuration if needed
2. Ensure proper Content Security Policy (CSP) headers
3. Update any custom authentication/authorization code

## Phase 6: Performance Improvements

1. Enable cache versioning
2. Update database configuration for improved performance
3. Enable zeitwerk autoloading mode

## Phase 7: Testing & Verification

1. Run full test suite: `bundle exec rspec`
2. Manual testing of core functionality:
- URL shortening
- URL expanding
- Error handling
- Edge cases

## Phase 8: Production Deployment Preparation

1. Update deployment scripts
2. Update CI/CD configuration (.travis.yml)
3. Create database migration plan
4. Update Procfile if using Heroku

## Phase 9: Documentation Updates

1. Update README.rdoc to README.md
2. Document any API changes
3. Update development setup instructions

## Specific Code Changes Required

1. `app/controllers/short_urls_controller.rb`:
```ruby
class ShortUrlsController < ApplicationController
  def create
    params.require(:url)
    url_mapping_value = URL_SHORTENER.shorten(params[:url])
    url_mapping = UrlMapping.find_or_create(url_mapping_value)
    render plain: url(url_mapping.short_path)
  end

  def show
    params.require(:short_path)
    normalized_short_path = NumberEncoder.normalize(params[:short_path])
    url_mapping = UrlMapping.find_by_short_path(normalized_short_path)
    
    if url_mapping
      render plain: url_mapping.long_url
    else
      render plain: "URL not found", status: :not_found
    end
  end
end
```

2. `config/routes.rb`:
```ruby
Rails.application.routes.draw do
  get '/:short_path' => 'short_urls#show'
  post '/' => 'short_urls#create'
end
```

## Final Notes

1. Keep track of all changes in a detailed changelog
2. Create detailed rollback procedures
3. Consider a staged rollout to production
4. Monitor for any performance issues or errors after deployment
5. Update monitoring and logging configurations for Rails 7.1

This upgrade plan focuses on maintaining the core URL shortening functionality while modernizing the codebase to take advantage of Rails 7.1 features and security improvements.
