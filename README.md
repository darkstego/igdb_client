# igdb_client
Ruby client interface for IGDB API. Supports API v4.

## Installation
```ruby
$ gem install igdb_client
```

## Usage
The structure of queries and results matches the [api documentaion.](https://api-docs.igdb.com/)
You will need client id and a valid token to access the API. The above link explains how to 
acquire them. 

##### Instance
```ruby
require 'igdb_client'

# initialize with client id and token
client = IGDB::Client.new("client_id","token") 

# Endpoint can optionally be provided to change from defaults of 'games'
other_client = IGDB::Client.new("client_id","token", 'characters') 

# Endpoint/token/client_id can be changed on a client
other_client.endpoint = 'games'

# Use the get method to fetch given the API params
client.get {fields: "name", limit: 10}

# Use search method to search
client.search("ibb and obb", {fields: "name,release_dates,esrb.synopsis,rating"})

# Use id if you want to match by id
client.id 1942

# You can run methods on alternate endpoints by using endpoint as method
client.character.id 14390

# Access retrieved data by using methods matching fields of data
results = client.platform.id 2
results[0].name
results[0].summary
```
