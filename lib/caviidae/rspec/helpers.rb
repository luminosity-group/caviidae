module Caviidae
  module RSpec
    module Helpers

      def db
        ::Caviidae.db
      end

      def sobject_types
        @sobject_types = db.list_sobjects unless @sobject_types
        @sobject_types
      end

      def current_user
        User.find_by_Username(Caviidae.configuration.username)
      end
      
    end
  end
end
