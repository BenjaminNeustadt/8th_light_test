require_relative './bookstorage'
require_relative './module/prompt'

class BookView

  include Prompt

  def initialize
    @storage = BookStorage.new.container
    @search_results = []
  end

  attr_reader :storage, :search_results

end

=begin
require 'dotenv'
Dotenv.load
require_relative '../lib/booksearch'
require_relative '../lib/strategy/testdata'
require_relative '../lib/strategy/bookdata'
require './lib/datapicker'
require 'colorize'

include DataPicker


@users_storage = BookStorage.new

def reset_search
  @search_results = []
end

def list_item(book, index)
  puts '-' * 23
  puts "Book number %s " % index.to_s.red
  puts "title: %s" % book[:title].black.on_white
  puts "author: %s" % book[:authors].to_s.blue.on_white
  puts "publisher: %s" % book[:publisher].to_s.yellow
  puts '-' * 23
  puts
end

def books_added
  puts "You added %<number_of>i books:" % {number_of: @users_storage.container.size}
  @users_storage.container.each do |book|
    puts '- %s'  % book[:title]
  end
end

reset_search

loop do


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
    data_query = BookSearch.new(SOURCE[choice])
    puts "AVAILABLE BOOKS: "
    data_query.available_books.each.with_index(1) do |book, index|
      list_item(book, index)
      @search_results << book
    end

  when 2
    @search_results.each.with_index(1) do |book, index|
      list_item(book, index)
    end

  when 3
    puts "Which of these books do you want to add to your library? Pick the respective number:"
    @search_results.each.with_index(1) do |book, index|
      list_item(book, index)
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
      list_item(book, index)
    end
    puts '=' * 23
    puts 'Total books selected: %i' % @users_storage.container.size
    puts '=' * 23
    puts

  when 0
    puts "SELECTED BOOKS"
    puts '+=' * 11 + '+'
    @users_storage.container.each.with_index(1) do |book, index|
      list_item(book, index)
    end
    puts '=' * 23
    puts 'Total books selected: %i' % @users_storage.container.size
    puts '=' * 23
    puts
    puts "Sad to see you go, until the next!"
    break
  end
end
=end
