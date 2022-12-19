require 'net/http'
require 'json'
require_relative '../lib/bookstorage'

class BookSearch

  LIMIT = 5

  API_KEY = JSON.parse(File.read("env.json"))["API_KEY"]
  private_constant :API_KEY

  private

  def initialize(query)
    raise ArgumentError, "BadQueryError" if query.nil?
    @url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&key=#{API_KEY}"
    @available_books ||= extract_from_raw(data_query)
    @storage = BookStorage.new
  end

  def data_query
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  public

  attr_reader :available_books, :url, :storage

  def add(book_data)
    storage.users_list << book_data
  end

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
