require_relative '../bin/bookview'

RSpec.describe BookView do

  before :each do
    @isolated_list = BookSearch.new('history', offline: true)
    @test_book_data = JSON.parse(File.read('test_data.json'))
  end

  context "reset_search" do
    it "is initially an empty array" do
      bookview = BookView.new
      expect(bookview.search_results).to eq([])
    end
  end

  context "users_storage" do
    it "is initially empty" do
      bookview = BookView.new
      users_books = bookview.users_storage.container
      expect(users_books).to eq([])
    end
  end

  context "list options for user" do
    it "displays 5 options" do
      bookview = BookView.new
      expected =
        <<~MENU
          1) search
          2) view search results
          3) add
          4) view
          0) exit
        MENU
       actual = bookview.menu
      expect(actual).to eq(expected)
    end
  end

  context "list single item" do
    it "displays book data in correct format" do
      bookview = BookView.new
      book = @isolated_list.available_books.first
      expected =
        <<~ITEM % book
        -----------------------
        Book number 1
        title: %<title>s
        author: %<authors>s
        publisher: %<publisher>s
        -----------------------
        ITEM
       actual = bookview.list_item(book, 1)
      expect(actual).to eq(expected)
    end
  end

  context "list single item" do
    it "displays correct book data" do
      bookview = BookView.new
      book = @isolated_list.available_books.first
      expected =
        <<~ITEM % book
        -----------------------
        Book number 1
        title: The History Book
        author: ["DK"]
        publisher: Dorling Kindersley Ltd
        -----------------------
        ITEM
       actual = bookview.list_item(book, 1)
      expect(actual).to eq(expected)
    end
  end

  context "books added" do

    it "reports a book added by user" do

      bookview = BookView.new
      book = @isolated_list.available_books.first
      bookview.users_storage.add(book)
      actual = bookview.books_added
      expected = "You added 1 book:\n- The History Book"
      expect(actual).to eq(expected)

    end

    it "reports the books added by user" do

      bookview = BookView.new
      books =  @isolated_list.available_books.take(3)
      books.each do |book|
        bookview.users_storage.add(book)
      end
      actual = bookview.books_added
      expected = "You added 3 books:\n- The History Book\n- A Short History of the World\n- The History Book"
      expect(actual).to eq(expected)

    end
  end

end

