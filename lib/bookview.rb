require_relative '../lib/booksearch'
require 'colorize'

class BookView

  OFFLINE = true

  MENU = {
    ACTION: {
      1 => "search",
      2 => "view search results",
      3 => "add",
      4 => "view",
      0 => "exit"
    }
  }

  LIST_ITEM =
    <<~EOS
      -----------------------
      Book number %<index>s
      title: %<title>s
      author: %<authors>s
      publisher: %<publisher>s
      -----------------------
      EOS

  ACTION_PROMPT = "%<option>s) %<action>s\n"

	LINE_STYLE = {
		default: '=======================',
		special: '+=+=+=+=+=+=+=+=+=+=+=+'
	}

	REPORT =
    <<~REPORT
      %<title>15s
      %<border>s
      %<booklist>s
      %<border>s
    REPORT

	def report_booklist
    @users_storage
      .container.each.with_index(1)
      .with_object(booklist = "") do |(book, index)|
        booklist << list_item(book, index)
      end

    REPORT % {booklist: booklist, border: LINE_STYLE[:special], title: 'BOOKLIST'}
  end

  def list_item(book, index)
    LIST_ITEM % {
      index:     index,
      title:     book[:title],
      authors:   book[:authors],
      publisher: book[:publisher]
    }
  end


  def initialize
    @search_results = []
    @users_storage  = BookStorage.new
  end

  attr_accessor :users_storage, :search_results

  def menu
    MENU[:ACTION].each_with_object("") do |(option, action), menu|
      menu << ACTION_PROMPT % {option: option, action: action}
    end
  end

  def reset_search
    @search_results = []
  end

  def total_books_selected
    <<~EOS % @users_storage.container.size
    =======================
      Total books selected: %i
    =======================
      EOS
  end

  def report_books_added
    list = []
    @users_storage.container.each do |book|
      list << "- #{book[:title]}"
    end

    plural = list.size == 1 ? "" : "s"

    "You added %<size>i book%<plural>s:\n%<list>s" %
      {size: list.size, plural: plural, list:list.join("\n")}
  end

  def add_user_book(choice)
    @users_storage.add(@search_results[choice]) if @search_results[choice]
  end

  def lookup_books(search_query)
    search = BookSearch.new(search_query, offline: OFFLINE)
    search.available_books.each.with_index(1) do |book, index|
      list_item(book, index)
      @search_results << book
    end
  end

  def report_retrieved_books
    "AVAILABLE BOOKS:\n" << @search_results
      .each.with_index(1)
      .with_object("") do |(book, index), report|
      report << list_item(book, index)
    end
  end


end
