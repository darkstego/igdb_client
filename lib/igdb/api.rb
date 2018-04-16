require 'igdb/connection'

module IGDB
   class API
      extend IGDB::Connection

      class << self
         attr_accessor :api_key
      end
   end
end
