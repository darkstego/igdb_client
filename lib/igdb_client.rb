require 'net/http'
require 'json'
require 'ostruct'

module IGDB
	class Client
		URL = "https://api.igdb.com/v4/"
		HEADER = {"Accept" => "application/json"}
		AUTHENTICATION_URL = "https://id.twitch.tv/oauth2/token"


		attr_accessor :client_id, :token, :endpoint

		def initialize(client_id, client_secret, endpoint = 'games')
			@client_id = client_id
			@client_secret = client_secret
			@endpoint = endpoint
			@token_expiration_time = Time.now - 60
			@access_token = "foo"
		end

		def get(params = {fields: '*'})
			uri = URI.parse(URL+@endpoint)
			data = params.map do |k,v|
				"#{k.to_s} #{v};"
			end.join('')
			response = Net::HTTP.post(uri,
			                          data,
			                          HEADER.merge({'Client-ID' => self.client_id,
			                                        'Authorization' => "Bearer " + self.access_token}))
			unless response.is_a? Net::HTTPSuccess
				error = "IGDB game query failed with with code #{response.code}\n"
				error += response.body
				raise error
			end
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

		private
		def access_token
			renew_access_token if Time.now > @token_expiration_time
			return @access_token
		end

		def renew_access_token
			query = {'client_id' => @client_id,
			         'client_secret' => @client_secret,
			         'grant_type' => 'client_credentials'}
			url = AUTHENTICATION_URL + '?' + URI.encode_www_form(query)
			response = Net::HTTP.post(URI(url),'')
			raise "Could not get Access Token for IGDB" unless response.is_a? Net::HTTPSuccess
			json = JSON.parse(response.body, object_class: OpenStruct)
			@token_expiration_time = json.expires_in.to_i
			@access_token = json.access_token
		end
	end
end
