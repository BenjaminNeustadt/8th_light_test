require 'net/http'
require 'json'
require_relative '../lib/bookstorage'

class BookSearch

  BOOK_LIMIT = 5

  def initialize(data)
    @data = data
    @available_books = extract(data)
    @storage = BookStorage.new
  end

  public

  attr_reader :available_books, :storage, :data

  def extract(book_data)
    book_data["items"].take(BOOK_LIMIT)
      .map { |item| item["volumeInfo"] }
      .map { |book| {
      title: book["title"],
      authors: book["authors"],
      publisher: book["publisher"]
    }
    }
  end

end
