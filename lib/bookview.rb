require_relative '../lib/booksearch'
require_relative '../lib/bookreport'
require_relative '../lib/prompt'

class BookView

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

  def lookup_books(search_query)
    @search_results = []
    search = BookSearch.new(search_query, offline: OFFLINE)
    search.available_books.each.with_index(1) do |book, index|
      item(book, index)
      @search_results << book
    end
  end

  # :TODO: this should actually be inside the lookup_books method, it reset the search
  def reset_search
    @search_results = []
  end
end

