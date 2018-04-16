# igdb_client
Ruby client interface for IGDB API

## Installation
```ruby
$ gem install igdb_client
```

## Usage
The client can be used in one of two ways. Either as an instance or a class.
They work pretty much in the same manner.

The structure of queries and results matches the [api documentaion.](https://igdb.github.io/api/)

##### Instance
```ruby
# initialize with api_key
client = IGDB::Client.new "api_key"

# methods match IGDB api endpoints, pass an optional hash as query params
client.games 1942, {fields: "name"}

# pass multiple ids in an array
client.games [1942,3344], {fields: "name,release_dates,esrb.synopsis,rating"}

# to run a text search on a resource, put search_ before resource name
client.search_games "ibb and obb"

# to count number of resources matched, put count_ before resource name
client.count_games {"filter[rating][gt]" => 75}

# Access retrieved data by using methods matching fields of data
results = client.platform 2
results[0].name
results[0].summary
```



##### Class Methods
```ruby
# initialize with api_key
IGDB::API.api_key = "api_key"

# methods match IGDB api endpoints, pass an optional hash as query params
IGDB::API.games 1942, {fields: "name"}

# pass multiple ids in an array
IGDB::API.games [1942,3344], {fields: "name,release_dates,esrb.synopsis,rating"}

# to run a text search on a resource, put search_ before resource name
IGDB::API.search_games "ibb and obb"

# to count number of resources matched, put count_ before resource name
IGDB::API.count_games {"filter[rating][gt]" => 75}

# Access retrieved data by using methods matching fields of data
results = IGDB::API.platform 2
results[0].name
results[0].summary
```
