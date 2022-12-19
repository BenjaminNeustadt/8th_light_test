require_relative '../lib/booklist'

RSpec.describe BookList do

  context "query" do

    it "returns only the first 5 elements of a query" do

      @grabbed_books = JSON.parse(File.read('test_data.json'))
      list = BookList.allocate

      actual = list.extract_from_raw(@grabbed_books)
      expected = 5
      expect(actual.length).to eq(expected)
    end

    xit 'can hold data via Storage' do
      list = BookList.new('tech')
      chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
      list.add(chosen_book)
      expect(list.stored_books).to eq [{author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}]
    end

  end

  context "extract data" do

    it "should result in a limited set of attributes: author, title, publisher" do

      @grabbed_books = JSON.parse(File.read('test_data.json'))
      list = BookList.allocate
      actual = list.extract_from_raw(@grabbed_books)
      expected =
        [
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

