# Caviidae

This is a gem that provides helpers for acceptance testing Visualforce apps
with Capybara, RSpec and the Databasedotcom gem. It makes use of the databasedotcom gem to allow you to use
fixtures that are automatically cleaned up between specs.

## Installation

Add this line to your application's Gemfile:

    gem 'caviidae'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caviidae

## RSpec Usage

Include the following in your `spec_helper.rb`:

```ruby
require "capybara"
require "capybara/dsl"
require "capybara/rspec"
require "caviidae/rspec"

Capybara.default_driver = :selenium
Capybara.app_host = 'http://myapp.com'

Caviidae.configure do |config|
  config.client_id      = ENV['SFDC_CLIENT_ID']
  config.client_secret  = ENV['SFDC_CLIENT_SECRET']
  config.username       = ENV['SFDC_USERNAME']
  config.password       = ENV['SFDC_PASSWORD']
  config.security_token = ENV['SFDC_SECURITY_TOKEN']
  # Specify any sObjects that should be materialized before running any tests.
  config.materialize    = ['User', 'Account']
end
```

Then create your request specs:

```ruby
require 'spec_helper'

describe "My App", :type => :request do
  let(:account) do
    Account.new(:Name => 'test', :OwnerId => User.first.Id).save
  end

  # After each test runs, any created sobjects will be removed.
  it "does something with the account" do
    visit '/'
    page.should have_content(account.Name)
  end
end
```

Any records that get created from the frontend will need to be manually
deleted. Something like this should work well enough:

```ruby
it "creates an order" do
  visit '/create_order'
  within('#form') do
    fill_in 'First name', :with => "TestXXX_First"
    fill_in 'Amount', :with => 1
  end
  click_on 'Submit'
  order = Order.last
  order.FirstName__c.should eq("TestXXX_First")
  order.delete
end

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
