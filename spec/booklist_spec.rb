require_relative '../lib/booklist'

RSpec.describe BookList do

  context "query" do

    it "returns only the first 5 elements of a query" do
      book = BookList.new('history')
      expect(book.search('history').length).to eq(5)
    end

    it 'can hold data via Storage' do
      list = BookList.new('tech')
      chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
      list.add(chosen_book)
      expect(list.stored_books).to eq [{author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}]
    end

  end

  context "grab_books" do

    it "should contain things related to the query" do

      @grabbed_books = JSON.parse(File.read('test_data.json'))

    end
  end


end

