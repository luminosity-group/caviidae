require "caviidae/databasedotcom"
require "caviidae/version"
require "caviidae/config"

module Caviidae
  
  class << self

    def materialize
      Caviidae.configuration.materialize.each do |sobject|
        db.materialize(sobject)
      end
    end

    def db
      unless @client
        @client = Databasedotcom::Client.new :client_id => configuration.client_id, :client_secret => configuration.client_secret, :host => configuration.host
        @client.authenticate :username => configuration.username, :password => "#{CGI::escape(configuration.password)}#{configuration.security_token}"
      end

      @client
    end

  end

end
