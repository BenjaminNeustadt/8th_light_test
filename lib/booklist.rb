require 'net/http'
require 'json'
require_relative '../lib/storage'

class BookList

  LIMIT = 5

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  private_constant :API_KEY

  private

  def initialize(query)
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @available_books = grab_books
    @storage = Storage.new
  end

  def grab_books
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end


  def limit(data)
    data.take(LIMIT)
  end

  public

  attr_reader :available_books, :url, :storage

  def extract_from_raw(data)
      data["items"].take(5)
        .map { |item| item["volumeInfo"] }
        .map { |book| {
        title: book["title"],
        authors: book["authors"],
        publisher: book["publisher"]
        }
      }
  end

  def search(query)
    limit(available_books["items"])
  end

  def add(book_data)
    storage.users_list << book_data
  end

  def stored_books
    storage.users_list
  end

end

if __FILE__ == $PROGRAM_NAME
  puts BookList.new('history').list('title')
end
