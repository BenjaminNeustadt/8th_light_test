require_relative '../lib/booksearch'

describe "Backend" do

  context "allows user to search for books" do

    it "returning 5 books from the search for a given word" do
      booksearch = BookSearch.new("tech")
      expect((booksearch.available_books).length).to eq 5
    end

    it "allowing a book to be added to storage" do
      booksearch = BookSearch.new("tech")
      retrieved_data = booksearch.available_books
      # We choose to add the first book
      chosen_book = retrieved_data[0]
      booksearch.add(chosen_book)

      expect(booksearch.storage).to be_truthy
      expect((booksearch.storage.users_list).length).to eq 1
    end

    it "allowing a book to be added to storage after one has already been added" do
      booksearch = BookSearch.new("tech")
      retrieved_books = booksearch.available_books
      # We choose to add the first book
      booksearch.add(retrieved_books.first)

      actual = (booksearch.storage.users_list).length
      expected = 1
      expect(actual).to eq expected

      # We choose to add another book
      booksearch.add(retrieved_books.last)
      actual = (booksearch.storage.users_list).length
      expected = 2
      expect(actual).to eq expected
    end

    it "storing authors, title, and publisher" do
      booksearch = BookSearch.new("tech")
      retrieved_books = booksearch.available_books
      booksearch.add(retrieved_books.first)
      actual = (booksearch.storage.users_list)
      expect(actual).to be_an Array

      actual = actual.first
      expect(actual).to be_a Hash
      expect(actual).to have_key :authors
      expect(actual).to have_key :publisher
      expect(actual).to have_key :title
    end

  end

  context "returns the error message if a bad query is made" do

    it "informs of a bad query for empty string" do

      expect {BookSearch.new(nil)}.to raise_error(ArgumentError)
    end
  end


end


# test for nil, for an edge case, e
# an empty space returns
#
# {
# "error": {
# "code": 400,
# "message": "Missing query.",
# "errors": [
# {
# "message": "Missing query.",
# "domain": "global",
# "reason": "queryRequired",
# "location": "q",
# "locationType": "parameter"
# }
# ]
# }
# }
