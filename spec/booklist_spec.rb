require_relative '../lib/booklist'

describe "Book list query" do

  it "returns only the first 5 elements of a query" do
    book = BookList.new('history')
    expect(book.search('history').length).to eq(5)
  end

end

