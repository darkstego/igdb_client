require 'net/http'
require 'json'
require 'ostruct'

module IGDB
   class Client
      URL = "https://api.igdb.com/v4/"
      HEADER = {"Accept" => "application/json"}

      attr_accessor :client_id, :token, :endpoint

      def initialize(client_id, token, endpoint = 'games')
         @client_id = client_id
         @token = token
         @endpoint = endpoint
      end

      def get(params = {fields: '*'})
         uri = URI.parse(URL+@endpoint)
         data = params.map do |k,v|
           "#{k.to_s} #{v};"
         end.join('')
         response = Net::HTTP.post(uri,
                                   data,
                                   HEADER.merge({'Client-ID' => self.client_id,
                                                 'Authorization' => "Bearer " + self.token}))
         response.value
         JSON.parse(response.body, object_class: OpenStruct)
      end

      def search(title, params = {fields: '*'})
         params[:search] = '"' + title + '"'
         get params
      end

      def id(id, params = {fields: '*'})
         params[:where] = "id = #{id}"
         get params
      end

      def method_missing(m, *args, &block)
         self.class.new(@client_id, @token, m.to_s)
      end
   end
end
