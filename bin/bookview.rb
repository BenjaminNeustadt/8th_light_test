require_relative '../lib/booksearch'

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

@users_storage = BookStorage.new

def reset_search
  @search_results = []
end

reset_search

loop do

  MENU[:ACTION].each do |option, action|
    print "#{ option}) "
    puts "#{ action}"
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
      puts "Book number %d " % index
      puts "title: %s" % book[:title]
      puts "author: %s" % book[:authors]
      puts "publisher: %s" % book[:publisher]
      puts
      @search_results << book
    end

  when 2
    @search_results.each.with_index(1) do |book, index|
        puts '-' * 23
        puts "Book number %d " % index
        puts "title: %s" % book[:title]
        puts "author: %s" % book[:authors]
        puts "publisher: %s" % book[:publisher]
        puts '-' * 23
        puts
    end

  when 3
    puts "Which of these books do you want to add to your library? Pick the respective number:"
    @search_results.each.with_index(1) do |book, index|
      puts "Book number %d " % index
      puts "title: %s" % book[:title]
      puts "author: %s" % book[:authors]
      puts "publisher: %s" % book[:publisher]
      puts
    end
    loop do
    print "Which book would you like to add? (pick a number, 0 to quit):"
      choice = gets.to_i - 1
      break if choice == -1
      @users_storage.add(@search_results[choice]) if @search_results[choice]
    p @users_storage
    end
    p @users_storage

  when 4
    puts "SELECTED BOOKS"
    puts '=' * 23
    @users_storage.users_list.each.with_index(1) do |book, index|
      puts '-' * 23
      puts "Book number %d " % index
      puts "title: %s" % book[:title]
      puts "author: %s" % book[:authors]
      puts "publisher: %s" % book[:publisher]
      puts '-' * 23
      puts
    end
    puts '=' * 23
    puts 'Total books selected: %i' % @users_storage.users_list.size
    puts '=' * 23
    puts

  when 0
    puts 'SELECTED BOOKS'
    puts '+=' * 11 + '+'
    @users_storage.users_list.each.with_index(1) do |book, index|
      puts '-' * 23
      puts "Book number %d " % index
      puts "title: %s" % book[:title]
      puts "author: %s" % book[:authors]
      puts "publisher: %s" % book[:publisher]
      puts '-' * 23
      puts
    end
    puts '=' * 23
    puts 'Total books selected: %i' % @users_storage.users_list.size
    puts '=' * 23
    puts
    puts "Sad to see you go, thank you for the nickle!"
    break
  end
end
