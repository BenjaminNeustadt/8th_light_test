require_relative '../lib/book'

describe "API return" do

  it "displays only the first 5 elements of a query" do
    book = Book.new
    expect(book.search('history').length).to eq(5)
  end

end

