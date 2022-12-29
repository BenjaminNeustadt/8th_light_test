class BookData

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  private_constant :API_KEY

  private

  attr_reader :url, :offline

  def initialize(query, offline: true)
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @offline = offline
  end

  public

  def data_query
    if offline
      return JSON.parse(File.read('test_data.json'))
    end
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

end

