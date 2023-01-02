
class BookData

  DEVELOPMENT = true

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  GOOGLE_URL = "https://www.googleapis.com/books/v1/volumes?q=%<query>s&key=#{API_KEY}"
  private_constant :API_KEY, :GOOGLE_URL

  private

  attr_reader :url, :environment

  def initialize(query, environment: DEVELOPMENT )
    @url = GOOGLE_URL % {query: query}
    @environment = :environment
  end

  public

  def data_query
    if environment
      return JSON.parse(File.read('test_data.json'))
    end
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

end

