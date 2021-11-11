# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'igdb/version'

Gem::Specification.new do |spec|
  spec.name          = 'igdb_client'
  spec.version       = '4.0.0'
  spec.authors       = ['Abdulla Bubshait']
  spec.email         = ['darkstego@gmail.com']

  spec.summary       = 'Ruby IGDB API Client'
  spec.description   = 'A Client for the Internet Game Database'
  spec.homepage      = 'https://github.com/darkstego/igdb_client'
  spec.license       = 'MIT'

  spec.files         = ['README.md', 'lib/igdb_client.rb']
  spec.require_paths = ['lib']
end
