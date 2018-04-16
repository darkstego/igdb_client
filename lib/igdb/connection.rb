require 'net/http'
require 'json'
require 'ostruct'

module IGDB
   module Connection
      URL = "https://api-endpoint.igdb.com/"
      HEADER = {"Accept" => "application/json"}
      HEADER_API_KEY_PARAM = "user-key"

      def get path, ids=nil, params={}
         uri = URI.parse(URL)
         http = Net::HTTP.new(uri.host, uri.port)
         http.use_ssl = true
         path_base = "/" + path + "/"
         path_id = ids.join(',') if ids.kind_of?(Array)
         path_id ||= ids.to_s
         path_params = URI.encode_www_form(params)
         full_path = path_base + path_id
         full_path << "?" + path_params unless path_params.empty?
         req = Net::HTTP::Get.new full_path, HEADER.merge({HEADER_API_KEY_PARAM => self.api_key})
         response = http.request(req)
         response.value
         JSON.parse response.body ,object_class: OpenStruct
      end

      def method_missing(m, *args, opts, &block)
         method = m.to_s
         if method[/^search_/]
            method[/^search_/] = ""
            # If only single string argument passed in args becomes empty
            # and string lands in opts
            if args.empty?
               args = [opts]
               opts = {}
            end
            params = {"search" => args.first}
            params = params.merge(opts) if opts
            self.get method, nil, params
         elsif method[/^count_/]
            method[/^count_/] = ""
            self.get method, "count", opts
         else
            self.get method, args, opts
         end
      end

   end
end
