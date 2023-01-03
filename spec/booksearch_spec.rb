require_relative '../lib/booksearch'
require_relative '../lib/strategy/testdata'

RSpec.describe BookSearch do

  before :each do
    @test_book_data = TestData.new.parse
    # @test_book_data = JSON.parse(File.read('spec/test_data.json'))
    @isolated_list = BookSearch.new('history', @test_book_data)
  end

  context "extract" do

    it "returns only the first 5 elements of a query" do
      list = @isolated_list
      actual = list.extract(@test_book_data)
      expected = 5
      expect(actual.length).to eq(expected)
    end

    it "should result in a limited set of attributes: author, title, publisher" do

      list = @isolated_list
      actual = list.extract(@test_book_data)

      expected = [
         {:authors   => ["DK"],
          :publisher => "Dorling Kindersley Ltd",
          :title     => "The History Book"},

         {:authors   => ["John Morris Roberts"],
          :publisher => "Oxford University Press, USA",
          :title     => "A Short History of the World"},

         {:authors   => ["Dorling Kindersley"],
          :publisher => nil,
          :title     => "The History Book"},

         {:authors   => ["James Raven"],
          :publisher => "Oxford University Press, USA",
          :title     => "The Oxford Illustrated History of the Book"},

         {:authors   => ["E. H. Gombrich"],
          :publisher => "Yale University Press",
          :title     => "A Little History of the World"}
      ]
      expect(actual).to eq expected
    end

  end

    context 'available books' do
      it "returns 5 books from the search for a given word" do
        booksearch = BookSearch.new("tech", @test_book_data)
        expect((booksearch.available_books).length).to eq 5
      end
    end

  context "storage" do

    it " can hold data" do
      booksearch = BookSearch.new("tech", @test_book_data)
      retrieved_data = booksearch.available_books
      # We choose to add the first book
      chosen_book = retrieved_data[0]
      booksearch.storage.add(chosen_book)

      expect(booksearch.storage).to be_truthy
      expect((booksearch.storage.container).length).to eq 1
    end

    it 'can have a book added via BookStorage' do
      list = @isolated_list
      chosen_book = {author: "Benjamin", title: "Notes As We Go", publisher: "Keeper of the Phones"}
      list.storage.add(chosen_book)
      expect(list.storage.container)
        .to eq [{author: "Benjamin", title: "Notes As We Go", publisher: "Keeper of the Phones"}]
    end

    it "can have a book added after one has already been added" do
      booksearch = BookSearch.new("tech", @test_book_data)
      retrieved_books = booksearch.available_books
      # We choose to add the first book
      booksearch.storage.add(retrieved_books.first)

      actual = (booksearch.storage.container).length
      expected = 1
      expect(actual).to eq expected

      # We choose to add another book
      booksearch.storage.add(retrieved_books.last)
      actual = (booksearch.storage.container).length
      expected = 2
      expect(actual).to eq expected
    end

    it "stores authors, title, and publisher" do
      booksearch = BookSearch.new("tech", @test_book_data)
      retrieved_books = booksearch.available_books
      booksearch.storage.add(retrieved_books.first)
      actual = (booksearch.storage.container)
      expect(actual).to be_an Array

      actual = actual.first
      expect(actual).to be_a Hash
      expect(actual).to have_key :authors
      expect(actual).to have_key :publisher
      expect(actual).to have_key :title
    end

  end

  context "data" do
    it "reads data from a data object " do
      booksearch= BookSearch.new('history', @test_book_data)
      expected = @test_book_data
      actual = booksearch.data
      expect(actual).to eq(expected)
    end
  end

end

