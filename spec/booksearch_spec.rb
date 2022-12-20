require_relative '../lib/booksearch'

RSpec.describe BookSearch do

  before :each do
    @isolated_list = BookSearch.new('history', offline: true)
    @test_book_data = JSON.parse(File.read('test_data.json'))
  end

  context "query" do

    it "returns only the first 5 elements of a query" do

      list = @isolated_list
      actual = list.extract_from_raw(@test_book_data)
      expected = 5
      expect(actual.length).to eq(expected)
    end

  end

  context "stored_books" do

    it 'can hold data via Storage' do
      list = @isolated_list
      chosen_book = {author: "Benjamin", title: "Notes As We Go", publisher: "Keeper of the Phones"}
      list.add(chosen_book)
      expect(list.storage.users_list)
        .to eq [{author: "Benjamin", title: "Notes As We Go", publisher: "Keeper of the Phones"}]
    end

  end


  context "extract data" do

    it "should result in a limited set of attributes: author, title, publisher" do

      list = @isolated_list
      actual = list.extract_from_raw(@test_book_data)

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

end

