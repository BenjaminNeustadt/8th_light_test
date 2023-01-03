require_relative '../lib/booksearch'
require_relative '../lib/strategy/bookdata'

RSpec.describe BookSearch do

  before :each do
    @test_book_data = JSON.parse(File.read('spec/test_data.json'))
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

  context "storage" do

    it 'can hold data via BookStorage' do
      list = @isolated_list
      chosen_book = {author: "Benjamin", title: "Notes As We Go", publisher: "Keeper of the Phones"}
      list.storage.add(chosen_book)
      expect(list.storage.container)
        .to eq [{author: "Benjamin", title: "Notes As We Go", publisher: "Keeper of the Phones"}]
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

