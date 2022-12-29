
class BookData

  DEVELOPMENT = true

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  private_constant :API_KEY

  private

  attr_reader :url, :environment

  def initialize(query, environment: DEVELOPMENT )
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
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

# Ideally we would set an environement with
# ENV['DEVELOPMENT']
# If you'd like to run this application in test mode offline, then you would do this command.
# TEST=true bin/bookview.rb in the command line

