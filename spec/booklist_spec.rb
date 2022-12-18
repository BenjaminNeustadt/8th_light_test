require_relative '../lib/booklist'

describe "Book list query" do

  it "returns only the first 5 elements of a query" do
    book = BookList.new('history')
    expect(book.search('history').length).to eq(5)
  end

end

describe "Book list users book list" do

  it "is initially empty" do
    book = BookList.new('history')
    expect(book.users_list).to eq []
  end

end

