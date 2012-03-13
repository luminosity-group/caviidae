# Capybara SFDC

This is a gem that provides helpers for integration testing Visualforce apps
with Capybara. It makes use of the databasedotcom gem to allow you to use
fixtures that are automatically cleaned up between specs.

## Installation

Add this line to your application's Gemfile:

    gem 'capybara_sfdc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara_sfdc

## Usage

Include the following in your `spec_helper.rb`:

```ruby
require "bundler"
Bundler.require :default, :development
require "pp"
require "capybara"
require "capybara/dsl"
require "capybara/rspec"

Capybara.register_driver :firefox_no_ssl do |app|
  require 'selenium/webdriver'
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.assume_untrusted_certificate_issuer = false

  Capybara::Selenium::Driver.new(app, :profile => profile)
end

Capybara.default_driver = :firefox_no_ssl
Capybara.app_host = 'https://www.google.com'

CapybaraSfdc.configure do |config|
  config.client_id      = ENV['SFDC_CLIENT_ID']
  config.client_secret  = ENV['SFDC_CLIENT_SECRET']
  config.username       = ENV['SFDC_USERNAME']
  config.password       = ENV['SFDC_PASSWORD']
  config.security_token = ENV['SFDC_SECURITY_TOKEN']
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
