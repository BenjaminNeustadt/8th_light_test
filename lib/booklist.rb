require 'net/http'
require 'json'

class BookList

  API_KEY = "AIzaSyDTsdQz7h-sK8Kf3shcnXrsLT1rWj5PYak"
  LIMIT = 5

  attr_reader :available_books, :url, :users_list
  def initialize(query)
    #include the book's author, title, and publishing company
    #list = [{ author:, title:, publishing company: }]
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @available_books = grab_books
    @users_list = []
  end

  def grab_books
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end

  def paginate(data)
    data.take(LIMIT)
  end

  def search(query)
    paginate(available_books["items"])
  end

  def add(book_data)
    users_list << book_data
  end

end

if __FILE__ == $PROGRAM_NAME
  puts BookList.new('history').list('title')
end
