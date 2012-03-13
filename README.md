# Caviidae

This is a gem that provides helpers for integration testing Visualforce apps
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

Capybara.app_host = 'http://myapp.com'

Caviidae.configure do |config|
  config.client_id      = ENV['SFDC_CLIENT_ID']
  config.client_secret  = ENV['SFDC_CLIENT_SECRET']
  config.username       = ENV['SFDC_USERNAME']
  config.password       = ENV['SFDC_PASSWORD']
  config.security_token = ENV['SFDC_SECURITY_TOKEN']
end
```

Then create your request specs:

```ruby
require 'spec_helper'

describe "My App", :type => :request do
  let(:account) do
    db.materialize('User')
    db.materialize('Account')
    Account.new(:Name => 'test', :OwnerId => User.first.Id).save
  end

  # After each test runs, any created sobjects will be removed.
  it "does something with the account" do
    visit '/'
    page.should have_content(account.Name)
  end
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
