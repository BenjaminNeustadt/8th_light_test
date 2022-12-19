require_relative '../lib/booklist'

RSpec.describe BookList do

  context "query" do

    it "returns only the first 5 elements of a query" do
      book = BookList.new('history')
      expect(book.search('history').length).to eq(5)
    end

    it 'can hold data via Storage' do
      book = BookList.new('tech')
      chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
      book.add(chosen_book)
      expect(book.report).to eq [{author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}]
    end

  end

end

