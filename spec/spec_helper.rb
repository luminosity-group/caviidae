require "bundler"
Bundler.require :default, :development
require "pp"
require "capybara"
require "capybara/dsl"
require "capybara/rspec"
require "caviidae/rspec"

Capybara.register_driver :firefox_no_ssl do |app|
  require 'selenium/webdriver'
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.assume_untrusted_certificate_issuer = false

  Capybara::Selenium::Driver.new(app, :profile => profile)
end

Capybara.default_driver = :firefox_no_ssl
Capybara.app_host = 'https://www.google.com'

Caviidae.configure do |config|
  config.client_id      = ENV['SFDC_CLIENT_ID']
  config.client_secret  = ENV['SFDC_CLIENT_SECRET']
  config.username       = ENV['SFDC_USERNAME']
  config.password       = ENV['SFDC_PASSWORD']
  config.security_token = ENV['SFDC_SECURITY_TOKEN']
  config.materialize    = ['User', 'Account']
end
