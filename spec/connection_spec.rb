require 'net/http'
require 'json'

describe "API call" do

  it "has a valid HTTP connection" do
    API_KEY = "AIzaSyDTsdQz7h-sK8Kf3shcnXrsLT1rWj5PYak"
    url = "https://www.googleapis.com/books/v1/volumes?q=history&key=#{API_KEY}"
    response = Net::HTTP.get_response(URI(url))
    expect(response.is_a?(Net::HTTPSuccess)).to be true
  end

end

