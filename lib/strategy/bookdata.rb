require 'net/http'
require 'json'

class BookData

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  GOOGLE_URL  = "https://www.googleapis.com/books/v1/volumes?q=%<query>&key=#{API_KEY}"

  attr_reader :url

  def initialize(query)
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @url = GOOGLE_URL % { query: query }
  end

  def parse
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

end
