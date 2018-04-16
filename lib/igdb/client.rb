require 'igdb/connection'

module IGDB
   class Client
      include IGDB::Connection

      attr_accessor :api_key

      def initialize(api_key)
         @api_key = api_key
      end

   end
end
