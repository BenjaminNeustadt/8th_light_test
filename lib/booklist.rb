require 'net/http'
require 'json'

class BookList

  API_KEY = "AIzaSyDTsdQz7h-sK8Kf3shcnXrsLT1rWj5PYak"
  LIMIT = 5

  def paginate(data)
    data.take(LIMIT)
  end

  def search(query)
    # these are hardcoded q = search query and API key found on google console
    url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body)
    paginate(response["items"])
  end

end
