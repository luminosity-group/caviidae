require 'capybara_sfdc/databasedotcom'
require 'capybara_sfdc/rspec'
require 'rspec'

module CapybaraSfdc
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    # Retrieve the databasedotcom client
    def client
      @client
    end

    # Pass in a block to configure
    def configure
      yield configuration
      client = Databasedotcom::Client.new :client_id => configuration.client_id, :client_secret => configuration.client_secret, :host => configuration.host
      client.authenticate :username => configuration.username, :password => "#{CGI::escape(configuration.password)}#{configuration.security_token}"
      ::RSpec.configure do |config|
        config.before(:each) { client.cleanup }
        config.after(:each)  { client.cleanup }
        config.include ::CapybaraSfdc::RSpec::Helpers
      end if configuration.rspec
      @client = client
    end
  end

  class Configuration
    # OAuth client id
    attr_accessor :client_id
    # OAuth client secret
    attr_accessor :client_secret
    # SFDC username
    attr_accessor :username
    # SFDC password
    attr_accessor :password
    # SFDC security token
    attr_accessor :security_token
    # Login host. Defaults to login.salesforce.com
    attr_accessor :host

    # Auto config rspec
    attr_accessor :rspec

    def initialize
      @security_token = "login.salesforce.com"
      @rspec = true
    end
  end
end
