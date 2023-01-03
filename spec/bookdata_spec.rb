require_relative '../lib/strategy/bookdata'

# # :TODO: REMOVE THIS test
# This test is now obsolete, as we do not need to check whether the data matches, we are always using a different file
RSpec.describe BookData do

  before :each do
    @test_book_data = JSON.parse(File.read('test_data.json'))
  end

  context "connection" do
    xit "reads data from the test file" do
      books = BookData.new('history')
      expected = @test_book_data
      actual = books.parse
      expect(actual).to eq(expected)
    end
  end

end


