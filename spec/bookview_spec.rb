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

    it "displays 5 options:search, add, view,view search, exit" do
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

end
