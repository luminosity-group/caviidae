require "caviidae/databasedotcom"
require "caviidae/version"
require "caviidae/config"

module Caviidae
  
  class << self

    def db
      @client
    end

    def connect
      client = Databasedotcom::Client.new :client_id => configuration.client_id, :client_secret => configuration.client_secret, :host => configuration.host
      client.authenticate :username => configuration.username, :password => "#{CGI::escape(configuration.password)}#{configuration.security_token}"
      @client = client
    end

  end

end
