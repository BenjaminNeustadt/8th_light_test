require 'net/http'
require 'json'
require_relative '../lib/bookstorage'

class BookSearch

  LIMIT = 5

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  private_constant :API_KEY

  private

  attr_reader :url, :offline

  def initialize(query, offline: false)
    raise ArgumentError, "BadQueryError" if query.nil?
    @offline = offline
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @available_books = extract_from_raw(data_query)
    @storage = BookStorage.new
  end

  def data_query
    if offline
      return JSON.parse(File.read('test_data.json'))
    end
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  public

  attr_reader :available_books, :storage

  def extract_from_raw(book_data)
    book_data["items"].take(LIMIT)
      .map { |item| item["volumeInfo"] }
      .map { |book| {
      title: book["title"],
      authors: book["authors"],
      publisher: book["publisher"]
    }
    }
  end

end
