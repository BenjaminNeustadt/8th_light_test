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

  def list_item(book, index)
    LIST_ITEM % {
        index:     index,
        title:     book[:title],
        authors:   book[:authors],
        publisher: book[:publisher]
      }
  end

  def books_added
    puts "You added %<number_of>i books:" % {number_of: @users_storage.container.size}
    @users_storage.container.each do |book|
      puts '- %s' % book[:title]
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  loop do

    MENU[:ACTION].each do |option, action|
      puts ACTION_PROMPT % {option: option.to_s.green, action: action.yellow}
    end

    puts "Enter a command : "
    choice =  gets.to_i

    case choice

    when 1
      reset_search

      print " What are you looking for? "
      choice = gets.chomp
      while choice.empty? do
        puts "Missing search query, go ahead and enter something..."
        print " What are you looking for? "
        choice = gets.chomp
      end
      data_query = BookSearch.new(choice, offline: OFFLINE)
      puts "AVAILABLE BOOKS: "
      data_query.available_books.each.with_index(1) do |book, index|
        puts list_item(book, index)
        @search_results << book
      end

    when 2
      @search_results.each.with_index(1) do |book, index|
        puts list_item(book, index)
      end

    when 3
      puts "Which of these books do you want to add to your library? Pick the respective number:"
      @search_results.each.with_index(1) do |book, index|
        puts list_item(book, index)
      end
      loop do
        print "Which book would you like to add? (pick a number, 0 to quit):"
        choice = gets.to_i - 1
        break if choice == -1
        @users_storage.add(@search_results[choice]) if @search_results[choice]
      end
      books_added

    when 4
      puts "SELECTED BOOKS"
      puts '=' * 23
      @users_storage.container.each.with_index(1) do |book, index|
        puts list_item(book, index)
      end
      puts total_books_selected
    when 0
      puts "SELECTED BOOKS"
      puts '+=' * 11 + '+'
      @users_storage.container.each.with_index(1) do |book, index|
        puts list_item(book, index)
      end
      puts total_books_selected
      puts "Sad to see you go, until the next!"
      break
    end
  end

end
# ideally this will go into its own file; perhaps called 'execute.rb'
