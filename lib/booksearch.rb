require 'net/http'
require 'json'
require_relative '../lib/bookstorage'
require_relative '../lib/bookdata'

class BookSearch

  LIMIT = 5

  def initialize(query)
    raise ArgumentError, "BadQueryError" if query.nil?
    @data = BookData.new(query).data_query
    @data_query = data
    @available_books = extract_from_raw(data_query)
    @storage = BookStorage.new
  end

  public

  attr_reader :available_books, :storage, :data, :data_query

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
