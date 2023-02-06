require 'dotenv/load'
require_relative '../lib/bookview'
require 'colorize'

module Book_Program

  def self.start

    session = BookView.new

    loop do

      puts session.menu
      puts "Enter a command : "
      choice =  gets.to_i

      case choice

      when 1
        print " What are you looking for? "
        choice = gets.chomp
        while choice.empty? do
          puts "Missing search query, go ahead and enter something..."
          print " What are you looking for? "
          choice = gets.chomp
        end
        session.lookup_books(choice)
        puts session.report_retrieved_books

      when 2
        puts session.report_retrieved_books

      when 3
        puts "Which of these books do you want to add to your library? Pick the respective number:"
        puts session.report_retrieved_books
        loop do
          print "Which book would you like to add? (pick a number, 0 to quit):"
          choice = gets.to_i - 1
          break if choice == -1
          session.add_user_book(choice)
        end
        puts session.report_books_added

      when 4
        puts session.report_booklist(Decorators::BORDER[:special])
        puts session.report_total_number_books_added

      when 0
        puts session.report_booklist(Decorators::BORDER[:special])
        puts session.report_total_number_books_added
        puts "Sad to see you go, until the next!"
        break
      end
    end

  end

end