require 'net/http'
require 'json'

describe "API call" do

  if $DEBUG
    it "has a valid HTTP connection" do
      API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
      url = "https://www.googleapis.com/books/v1/volumes?q=history&key=#{API_KEY}"
      response = Net::HTTP.get_response(URI(url))
      expect(response.is_a?(Net::HTTPSuccess)).to be true
    end
  end

end

