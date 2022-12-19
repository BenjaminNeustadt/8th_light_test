require 'net/http'
require 'json'
require_relative '../lib/storage'

class BookList

  LIMIT = 5

  API_KEY = "AIzaSyDTsdQz7h-sK8Kf3shcnXrsLT1rWj5PYak"
  private_constant :API_KEY

  private

  def initialize(query)
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @available_books = grab_books
    @storage = Storage.new
  end

  def grab_books
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end

  def paginate(data)
    data.take(LIMIT)
  end

  public

  attr_reader :available_books, :url, :storage

  def search(query)
    paginate(available_books["items"])
  end

  def add(book_data)
    storage.users_list << book_data
  end

  def report
    storage.users_list
  end

end

if __FILE__ == $PROGRAM_NAME
  puts BookList.new('history').list('title')
end
