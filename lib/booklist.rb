require 'net/http'
require 'json'

class BookList

  API_KEY = "AIzaSyDTsdQz7h-sK8Kf3shcnXrsLT1rWj5PYak"
  LIMIT = 5

  def paginate(data)
    data.take(LIMIT)
  end

  def search(query)
    url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body)
    paginate(response["items"])
  end

end

if __FILE__ == $PROGRAM_NAME
  puts BookList.new('history').list('title')
end
