require 'capybara_sfdc/rspec/config.rb'

module CapybaraSfdc
  module RSpec
    module Helpers

      def db
        ::CapybaraSfdc.client
      end
      
    end
  end
end
