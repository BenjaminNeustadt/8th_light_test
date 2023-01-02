require 'net/http'
require 'json'
require_relative '../lib/bookstorage'
require_relative '../lib/bookdata'

class BookSearch

  BOOK_LIMIT = 5

  private

  def initialize(query)
    @data = BookData.new(query).data_query
    @available_books = extract(data_query)
    @storage = BookStorage.new
  end

  def data_query
    data
  end

  public

  attr_reader :available_books, :storage, :data

  def extract(book_data)
    book_data["items"].take(BOOK_LIMIT)
      .map { |item| item["volumeInfo"] }
      .map { |book| {
      title:     book["title"],
      authors:   book["authors"],
      publisher: book["publisher"]
    }
    }
  end

end
