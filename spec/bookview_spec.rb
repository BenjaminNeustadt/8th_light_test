require_relative '../lib/bookview'

RSpec.describe BookView do

  before :each do
    @test_book_data = TestData.new.parse
    @isolated_list = BookSearch.new(@test_book_data)
  end

  context 'initialize' do
    it 'instantiates an instance of BookStorage' do
      bookview = BookView.new
      expect(bookview.storage).to eq []
    end

    it 'instantiates with an empty search results' do
      bookview = BookView.new
      expect(bookview.search_results).to eq []
    end
  end

  context 'menu' do
    it 'shows the game menu' do
      bookview = BookView.new
      expected =
        <<~MENU
        1) search
        2) view search results
        3) add
        4) view
        0) exit
        MENU

      expect(bookview.menu).to eq expected
    end
  end

  context 'list single item' do
    it 'displays book data in correct format' do
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
      actual = bookview.item(book, 1)
      expect(actual).to eq expected
    end
  end

end
