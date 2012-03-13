require 'caviidae/databasedotcom'
require 'caviidae/rspec'
require 'rspec'

module Caviidae
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    # Pass in a block to configure
    def configure
      yield configuration
      ::RSpec.configure do |config|
        config.after(:each) { Caviidae.db.cleanup }
        config.include ::Caviidae::RSpec::Helpers
      end if configuration.rspec
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
