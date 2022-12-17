require 'net/http'
require 'json'

# these are hardcoded q = search query and API key found on google console
url = "https://www.googleapis.com/books/v1/volumes?q=history&key=AIzaSyDTsdQz7h-sK8Kf3shcnXrsLT1rWj5PYak"

uri = URI(url)
res = Net::HTTP.get_response(uri)
response = JSON.parse(res.body)
binding.irb
puts response
