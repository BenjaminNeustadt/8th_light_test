require_relative '../lib/booksearch'
require_relative './module/bookreport'
require_relative './module/prompt'
require_relative './datapicker'

class BookView

	include DataPicker
	include Report
	include Prompt

  OFFLINE = true

  def initialize
    @search_results = []
    @users_storage  = BookStorage.new
  end

	public

  attr_accessor :users_storage, :search_results

  def add_user_book(choice)
    @users_storage.add(@search_results[choice]) if @search_results[choice]
  end

  def lookup_books(choice)
    @search_results = []
    search = BookSearch.new(SOURCE[choice])
    search.available_books.each.with_index(1) do |book, index|
      item(book, index)
      @search_results << book
    end
  end

end

