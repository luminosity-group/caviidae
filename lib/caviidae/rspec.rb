require 'caviidae/rspec/config.rb'

module Caviidae
  module RSpec
    module Helpers

      def db
        ::Caviidae.client
      end
      
    end
  end
end
