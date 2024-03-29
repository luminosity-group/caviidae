require 'caviidae/databasedotcom'

module Caviidae
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    # Pass in a block to configure
    def configure
      yield configuration
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
    # An array of sobjects to materialize at the start
    attr_accessor :materialize

    def initialize
      @host = "login.salesforce.com"
      @materialize = []
    end
  end
end
