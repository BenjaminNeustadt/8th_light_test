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

describe "Book add to users list" do

  it "can have book data added" do
    book = BookList.new('history')
    test_data = JSON.parse(File.read('test_data.json'))
    # Potentially use a mock here instead of using 'test_data.json'
    chosen_book = test_data["items"].first["volumeInfo"]["title"]
    book.add(chosen_book)
    expect((book.users_list).length).to eq 1
  end

  it "can have correct data added" do
    #include the book's author, title, and publishing company
    #list = [{ author:, title:, publishing company: }]
    book = BookList.new('history')
    chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
    book.add(chosen_book)
    expect(book.users_list).to eq [{author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}]
  end

  it "can have correct data added" do
    book = BookList.new('history')
    chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
    book.add(chosen_book)
    expect(book.users_list.first[:author]).to eq 'Benjamin'
  end

end

